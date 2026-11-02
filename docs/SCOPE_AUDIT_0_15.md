# Scope audit — checkpoint 0.15

This build implements the agreed rule-correction check for T7/T8 in the existing benefits case. It adds no new source chapter, case domain, principal abstraction or policy.

## Operative path and scope

RuleCorrection.lean has three concrete finite constructors. Allocation instantiates ResponsibilityAllocation over the existing design/use context and developer/deployer roles; criteria-revision power concerns the design context explicitly. Process instantiates ConsultationProcess over the two existing scoring-rule selectors. Notice composes the recorded proposal, actual rule-update result and Fairness.notice calculation. None is a new reusable domain abstraction; the 30 principal definitions remain as listed in RESULT_COVERAGE.md. The concrete-instance exclusion is not permission to hide future new abstractions.

A logged and amendable objection can coexist with an unchanged penalty when the design reviewer lacks revision power. A real denial assignee is not assigned to the criteria context and cannot revise that rule. An assigned, empowered design reviewer can apply the valid proposal, and the evaluator's returned selector actually controls the recomputed notices: assisted intake moves from score 45/deny to 60/grant while the online application stays 60/grant. Relevant eligibility, cutoff, request operations, design/use assignment and person-facing safeguard channels are preserved. Award-dependent exclusion/harm can change.

The guard computes the adopted policy assessment on the candidate awards, rather than treating an audit label as sufficient. A corrected rule rejects requests to restore the known bad penalty; induction proves preservation through every finite sequence of the modeled revision attempts. This result concerns the two-rule candidate family and perfect guard enforcement. It includes no delivery/authentication guarantee, unmodeled direct edits, retroactive case reopening, payments or physical restoration.

## Source and evidence

MH-019 (§104), MH-036/038 (§109) and MH-040 (§111) motivate design scrutiny, choices/corrections and responsible design. I30/A39/A40 record this operative-rule realization. The nine audited declarations form one bounded objection-to-criteria-correction package with helpers and a finite-sequence invariant, not nine independent research findings. Request handling is not public consultation or approval of this research report.

T7/T8 now have a concrete, verified link to changing the governing criteria in this case. The next original-target work is T3/T6: connect accessible appeal, review and an exercisable correction sequence for a contested decision, keeping that distinct from changing a rule for recomputed applications. Then perform the original completion audit and writing/release work. The original substantive-result audit, 2,000–5,000-line target, 4,000/5,000-line controls, three domains and 30-definition ceiling remain in force.
