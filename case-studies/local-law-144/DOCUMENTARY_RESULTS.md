# Documentary closeout

9 November 2026 · Build 0.4

The final sample contains **20 distinct employer groups** from the recorded discovery queue. Five have deep reviews. The planned target was 25 and the bounded search ended five groups short. Every included row received a same-reviewer source reconciliation. The [freeze manifest](data/corpus_freeze.json) fixes the roster and hashes the research ledgers. The [source register](data/sources.json) records the document versions and retrieval limits. Original source bytes were not preserved.

| Evidence in reviewed document sets | Documented | Not described | Unclear |
| --- | ---: | ---: | ---: |
| Institution identified | 20 | 0 | 0 |
| Candidate contact | 18 | 2 | 0 |
| Review role | 12 | 8 | 0 |
| Assignee tied to the specific case | 0 | 20 | 0 |
| Scoped post-decision or assessment-result review route | 2 | 12 | 6 |
| Instructions to request alternative selection | 7 | 11 | 2 |
| Instructions to request accommodation | 14 | 4 | 2 |

The denominator is 20 in each row. No row had a not-applicable code. Counts describe documents captured by a search that favors publicly discoverable notices and audits. “Not described” means the reviewed material supplied no scoped description. “Unclear” preserves ambiguity, conditions on eligibility or inaccessible text. Neither category establishes the actual availability of a procedure. The validator reproduces the counts from the [coded records](data/employers.json).

## Which review routes count?

- **Instacart (E003).** One documented assessment-result review route for CodeSignal scores or proctoring results in the applicable population. CodeSignal is an additional tool in the notice. This evidence gives no primary-tool or universal final-rejection coverage. [Screening tools notice](https://www.instacart.careers/ai-assisted-screening-tools-notice)
- **NBCUniversal (E004).** One general recruitment-decision review request in the March 2026 candidate policy. The passage does not name SmartAssistant, the primary tool in the earlier NYC notice, or specify a distinct final-rejection procedure. [Candidate privacy policy, §2.5](https://www.nbcunicareers.com/candidate-privacy-policy)

Thus two groups have a scoped positive, one assessment-specific and one general recruitment-decision route. Neither positive explicitly identifies the designated primary tool as covered by a post-decision procedure. Neither specifically documents a distinct final-rejection route. These are narrower documentary counts with unresolved coverage outside the two positives.

The seven alternative-selection positives are E003, E004, E005, E012, E014, E017 and E018. E004 comes from the historical 2024 notice. E005 gives instructions in a notice that describes tool use prospectively. E003 supplies NYC instructions and additional routes for specific tools or stages. The remaining four are scoped to the roles or populations of their notices. A published instruction establishes a way to request an alternative within its stated scope. Whether it is granted and currently operational requires separate evidence.

## Targeted source checks at closeout

The checks below address decisive passages. The original review scopes and retrieval dates remain in the ledgers.

| Group | Passages revisited on 9 November |
| --- | --- |
| Citizens | E001-S1 audit introduction and E001-S5 applicant policy. The policy evidence for geographically scoped rights remains separate from the NYC count. |
| Snowflake | E002-S1 NYC audit notice and E002-S2 AI contest provision. The latter is conditional on applicable law. |
| Instacart | E003-S1 NYC instructions, Greenhouse Real Talent section and CodeSignal human review section. The CodeSignal route remains tool- and stage-specific. |
| NBCUniversal | E004-S2 §2.5 further human review and E004-S1 alternative-selection paragraph. The two passages carry different dates and scopes. |
| SharkNinja | E005-S1 NYC alternative-selection and audit sections and E005-S2 general privacy-rights section. The NYC notice describes prospective use and the later reconsideration scope remains unclear. |

These counts establish a documentary basis for modeling a review request, a case-specific finding and the authority to change a hiring assessment as separate facts. The workflow tested in Lean will be hypothetical.
