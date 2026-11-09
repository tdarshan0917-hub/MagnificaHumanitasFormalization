#!/usr/bin/env python3
"""Validate documentary provenance and block premature sample claims; no network."""
import csv
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(name):
    return json.loads((ROOT / 'data' / name).read_text())


def require(condition, message):
    if not condition:
        raise ValueError(message)


def main():
    study = read('study.json')
    sources = read('sources.json')
    claims = read('legal_claims.json')
    employers = read('employers.json')
    discovery = read('discovery_log.json')
    source_ids = {s['id'] for s in sources}
    require(len(source_ids) == len(sources), 'Duplicate source IDs')
    require(len({c['id'] for c in claims}) == len(claims), 'Duplicate claim IDs')
    require(len({e['id'] for e in employers}) == len(employers), 'Duplicate employer IDs')
    included = [e for e in employers if e['included']]
    require(len(included) <= study['target_employers'], 'Sample exceeds fixed scope')
    require(sum(e['deep'] for e in included) <= study['target_deep'], 'Deep sample exceeds scope')
    require(len({e['corporate_group'].casefold() for e in included}) == len(included), 'Duplicate group in denominator')
    statuses = {'documented', 'not_described', 'unclear', 'not_applicable'}
    checks = {'identify_responsibility', 'examine_rule', 'accept_challenge', 'deliver_finding', 'apply_correction', 'check_result'}
    quick = {'institution_identified', 'candidate_contact', 'review_role', 'case_assignee', 'post_decision_review_nyc', 'alternative_process_instructions', 'accommodation_instructions'}
    for s in sources:
        require(s['url'].startswith('https://'), f"Non-HTTPS source {s['id']}")
        require(s['retrieved_on'] and s['retrieval_method'] and s['publisher'], f"Missing provenance {s['id']}")
    for c in claims:
        require(c['source_ids'] and set(c['source_ids']) <= source_ids, f"Missing claim source {c['id']}")
        require(c['locator'] and c['boundary'] and set(c['checks']) <= checks, f"Unbounded claim {c['id']}")
    for e in employers:
        require(set(e['quick_scan']) == quick, f"Quick-scan coverage {e['id']}")
        if e['deep']:
            require(set(e['deep_checks']) == checks, f"Deep-check coverage {e['id']}")
        require(set(e['source_ids']) <= source_ids, f"Unknown employer source {e['id']}")
        if e['second_pass_complete']:
            review = e.get('second_pass', {})
            require(review.get('date') and review.get('method') and review.get('changes'),
                    f"Missing second-pass record {e['id']}")
            require(review.get('codebook') == study['codebook'],
                    f"Second pass uses an older codebook {e['id']}")
        fields = list(e['quick_scan'].values()) + list(e['deep_checks'].values()) + e['other_scoped_rights']
        for item in fields:
            require(item['status'] in statuses, f"Invalid evidence status {e['id']}")
            require(item['source_ids'] and set(item['source_ids']) <= set(e['source_ids']), f"Unlinked evidence {e['id']}")
            require(item['locator'] and item['population'] and item['note'], f"Missing scope/locator {e['id']}")
            if study['codebook'] == '0.2':
                require(all(item.get(k) for k in ['tool_scope', 'stage', 'time_scope']),
                        f"Missing tool/stage/time boundary {e['id']}")
            require(item['operationally_verified'] is False, 'Documentary build cannot assert operational performance')
        require(any(d.get('employer_id') == e['id'] and d['decision'].startswith('include') for d in discovery), f"Missing inclusion trail {e['id']}")
    for name in ['worksheet.csv', 'authority.csv', 'findings.csv']:
        with (ROOT / 'review-kit' / name).open(newline='') as f:
            rows = list(csv.reader(f))
        require(rows and len(set(rows[0])) == len(rows[0]), f'Invalid CSV header {name}')
        require(all(len(row) == len(rows[0]) for row in rows), f'Ragged CSV {name}')
    require(not list(ROOT.rglob('*.lean')), 'No unbuilt Lean files in documentary directory')
    ready = study['corpus_frozen']
    if ready:
        freeze = read('corpus_freeze.json')
        require([e['id'] for e in included] == freeze['included_employer_ids'],
                'Included employer roster differs from frozen corpus')
        require(len(included) == freeze['final_employers'], 'Frozen denominator mismatch')
        require(study['target_employers'] - len(included) == freeze['discovery_shortfall'],
                'Frozen discovery shortfall mismatch')
        require(sum(e['deep'] for e in included) == study['target_deep'],
                'Frozen corpus has incomplete deep-review coverage')
        require(all(e['second_pass_complete'] for e in included),
                'Frozen corpus contains an unreconciled review')
        for name in ['employers.json', 'sources.json', 'legal_claims.json', 'discovery_log.json']:
            digest = hashlib.sha256((ROOT / 'data' / name).read_bytes()).hexdigest()
            require(digest == freeze['ledger_sha256'].get(name), f'Frozen ledger changed: {name}')
    print(f"Documentary validation passed: {len(sources)} sources, {len(claims)} source claims, {len(included)} employer record(s), {sum(e['deep'] for e in included)} deep-review sheet(s).")
    if not ready:
        print('Exploratory build: final sample rates withheld; corpus/review completion pending.')
    else:
        for key in sorted(quick):
            counts = {s: sum(e['quick_scan'][key]['status'] == s for e in included) for s in sorted(statuses)}
            print(f'{key}: {counts}; denominator={len(included)} employer document sets, not all NYC employers.')


if __name__ == '__main__':
    main()
