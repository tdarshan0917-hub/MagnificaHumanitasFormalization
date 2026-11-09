# Protocol 0.1

Recorded 4 November 2026 after examining the Citizens pilot. This is a prospective rule for expanding the corpus, not a preregistration of a completed sample.

## Fixed scope

- New York City Local Law 144 **of 2021**, its implementing rules and official guidance.
- Hiring/screening only; no new benefits, parole or EU case domain.
- 25 distinct employer groups total, including five deep reviews. Target five deep cases = the first five included employers; Citizens is the disclosed pilot and first case. Do not choose deep cases by their scores.
- Primary unit: an employer's published document set associated with an AEDT hiring use. Count a corporate group once; record the named entity and tool. Additional tools are annotated, not extra employers. If several tools qualify, use the first in the employer's own notice; break ties by tool name alphabetically.
- Selection establishes membership in a public-disclosure sample. It does not establish present statutory coverage, current tool use or legal compliance for an individual job.

## Discovery and inclusion

Starting with the recorded pilot, use these query families in order; preserve each query, engine, date, candidate order, URL and inclusion/exclusion decision:

1. `"Local Law 144" "bias audit" careers`
2. `"automated employment decision tool" "candidate" "audit" employer`
3. `"Local Law 144" "alternative selection process" employer`

Review up to the first 20 distinct employer candidates returned per query, following at most two result pages per query. If fewer than 25 qualify, report the shortfall and proposed protocol amendment before adding another query family. Search rankings change; the discovery log, not a claim of population randomness, fixes order. Earlier exploratory results are recorded separately and have no implicit inclusion priority beyond the declared pilot.

Include the first 25 eligible employers in logged order. Eligibility requires an employer-controlled or employer-linked primary document describing its hiring AEDT use or publishing a Local Law 144 audit/notice. Keep an unlocatable notice as missing when another qualifying document exists; do not drop an employer because review/appeal information is missing. Vendor-only demonstrations without an identified employing organization and third-party commentary alone are excluded. Do not exclude for an old audit date: record it without inferring ongoing use.

Record duplicates, unavailable pages and excluded candidates with reasons. No fabricated applications, test complaints, candidate accounts or contact with employers are part of this study.

## Equal retrieval effort

For each quick scan inspect: the qualifying notice/audit landing page, linked candidate help/accommodation page, hiring process/assessment guidance, and applicant privacy policy where available. Follow their directly relevant links and inspect up to six employer documents, then run one domain-restricted search each for `appeal`, `reconsideration` and `alternative assessment`. Log blocked or unreviewed materials; a search engine returning no result is not proof of absence. Deep reviews can add two documents with the reason logged. Never enlarge one employer's search solely to get a desired result.

Citizens' six-document pilot was collected before this protocol was frozen. The pilot's searches used narrower assessment terms and were poorly domain-constrained; they are logged as a limitation. The prescribed three domain searches were then repeated and logged; a second coding pass is still required. Freeze any codebook revision after the first five deep cases, then recode all five and apply it to the remaining 20. Preserve all revisions.

## Three scan questions

1. Is responsibility disclosed at institution, functional role and individual-case assignee levels? Record these separately; contactability is a separate flag.
2. Is a post-decision challenge/reconsideration route described for the relevant NYC hiring population? Record other geographic or conditional rights separately.
3. Are alternative-selection instructions and accommodation instructions described? Do not combine them or infer that a request guarantees provision.

Store the status, source ID, section locator, population, time scope and a short rationale for each answer. Six deep-review checks use the same evidence register. No composite score or unsupported pass/fail ranking.

## Counting and review

One employer is one denominator unit; never count audit comparisons or documents as employers. Report documented/not_described/unclear separately, including unavailable evidence. The denominator is the actual included sample, not the target of 25. All rows receive a second reading against sources; label this a same-reviewer consistency check unless a second person actually codes them. Freeze the roster and source versions before aggregate reporting. If the target is not met, report actual n and the reason; do not silently substitute a more convenient sample.

The documentary result is phrased as 'X of n reviewed employer document sets describe…'. It is not a citywide prevalence estimate or a measurement of operational availability. Report the deliberate bias toward organizations publishing identifiable AEDT materials. Applicant-specific notices, internal procedures and actual case logs may be unavailable.

## Source versions and release

Register URL, publisher, retrieval date, document date if visible, exact section and retrieval limitations. Indexed web text is not a byte-for-byte live capture. This build retains authored evidence notes and links; it does not claim archived source bytes or source-file hashes. Before final counts, revisit sources and preserve permitted dated excerpts/captures with hashes where possible; otherwise explicitly retain a source-version limitation. A changed page triggers recoding of affected rows.

Publish the short report, coded data and source/evidence appendix, formal model and dependency audit, plus the five review-kit instruments. Completion requires all scoped claims have a disposition, not a predetermined number of negative findings. A working challenge route may end in a reasoned upheld decision; a corrected assessment does not imply entitlement to a job.

## Amendment 0.2 — five-review calibration, 5 November 2026

The original three discovery families returned four eligible groups including the fixed Citizens pilot. A bounded fourth family was added: `"Local Law 144" "bias audit" "candidate privacy"`. The first new eligible result was SharkNinja; its country-site result was verified through the employer's official US notice. The four additions remain in discovery order: Snowflake, Instacart, NBCUniversal, SharkNinja. No employer was selected because a protection was missing.

**Sequencing deviation:** the supplemental query was executed before this written amendment was entered. This is a disclosed methodological change, not prospective preregistration. `data/discovery_results.json` preserves grouped exclusions and duplicate handling. It is not a complete ranked URL archive. The result-set shortage justifies the bounded extension; it does not establish that no other employers could be found. Future additions must preserve the logged order and record any further expansion before use.

Codebook 0.2 is frozen for the remaining quick scan, subject to explicitly logged amendments and recoding. The first five records have been reconciled under it. Second pass means the same assistant reread decisive sections and checked coding against the source set; it is not independent coding or a reliability statistic.

Each observation now carries tool, stage and time scope. Employer-group counts may describe a provision for **some** covered tools, but must not be reported as all-tools coverage. A separate primary-tool analysis is required before final rates. The primary tool remains the first tool in the selected employer notice; other tools receive explicit annotations. Source freshness, present use and operational delivery remain separate questions. No final rates are released in build 0.2.

## Amendment 0.3 — discovery queue, 9 November 2026

The four recorded queries were rerun in order. The available search interface returned one result set per query. Three additional employer leads surfaced (PwC, Aon and DoorDash), leaving the target of 25 out of reach through those results. Preserve their order before adding leads from the ACLU's public Local Law 144 audit tracker, which surfaced in the first query.

For the supplemental queue, record the tracker version and use the order of its public employer listing, deduplicated by corporate group. Take the first eligible groups until reaching 25 total. Verify each lead against an employer-controlled or employer-linked primary document. Keep failed retrievals and reasons for exclusion. Apply the same coding rules and retrieval bounds to included groups. The tracker supplies leads only.

The tracker contains many vendor product audits and several captures for which the underlying employer document could not be read. Its verified employer leads still leave a shortfall against 25. After the tracker queue, run one additional family, `"notice" "automated employment decision tools" "reasonable accommodation" hiring`, with the existing result and deduplication limits. This last family may enrich notices that describe accommodation; keep the discovery stratum visible in any later count.

The accommodation query surfaced a duplicate NBCUniversal notice and no new group. To address the remaining shortfall, run a final pair of employer job-board searches in the order below. Hosted job notices qualify when the posting identifies the employing entity and describes its own tool use. Tag this stratum separately because boards and shared vendor templates can cluster together.

1. `site:job-boards.greenhouse.io "AEDT" "Covey" "NYC"`
2. `site:jobs.lever.co "automated employment decision tool" "New York City"`

Stop discovery after these results and report any remaining shortfall.

## Amendment 0.4 — close the documentary sample, 9 November 2026

The planned target remains 25. The final denominator is 20 distinct employer groups, with five deep reviews. Discovery ended at the recorded bounds and left five groups short of target. All included groups completed the same-reviewer reconciliation. The frozen roster and hashes identify the exact study ledgers used for counts.

The freeze preserves the dated source observations already in the register. The source-byte limitation remains. The closeout records targeted checks of decisive passages from the five deep cases. Current availability of employer procedures and their execution remain unverified.
