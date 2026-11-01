# Interpretation ledger

All entries are modeling choices. Selected consequences of the responsibility and recourse choices have now been checked in Lean; textual fidelity remains a separate editorial judgment. Source pointers identify the motivation for a choice, not textual proof of our exact formula.

| ID | Choice | Conservative prototype | Stronger or alternative reading | Consequence to test |
|---|---|---|---|---|
| I01 | Responsibility bearer, §§103,105 | Identifiable person or institution | Natural person required for each decision, with an explicit institutional-to-human allocation rule | T1/T2 may depend on the allocation rule |
| I02 | Impact trigger, §102 | Decision-specific evidence of a rights/opportunity/freedom impact | Classify all decisions in selected domains as high-impact | Employment domain membership alone is insufficient in the conservative model |
| I03 | Appeal scope, §§104–105 | Exclusion triggers the person-specific appeal duty | Retain exclusion duties and additionally require appeal for each affected person in a high-impact decision | The broader trigger is explicit A04; appeal alone is not full remedy or universal meaningful recourse |
| I04 | Remedy scope, §105 | Actual harm creates a remedy duty; separately model prospective remedy capacity | Every affected person always has a complete remedy procedure | No inference from capability to successful restoration; no inference from affectedness to actual harm |
| I05 | Accountability, §105 | Define answerability, identifiability, monitoring, challenge, and remedy as separate components | Composite accountability package bundles these components under specified triggers | C1/C3 must state which notion is used |
| I06 | Oversight level, §§106,108 | Regime-level independent oversight; deployment-specific effective oversight | Each high-impact decision has a specific independent reviewer | T6 needs a bridge between governance levels |
| I07 | Participation, §§107–109 | Meaningful contribution and opportunity to correct | Veto, ownership, or final decision authority | C6 tests why the stronger powers need extra premises |
| I08 | Transparency, §§105,111 | Disclosure of responsibility, process, and pertinent decision information | Full technical interpretability or publication of all model parameters | Neither reading automatically supplies appeal or a remedy |
| I09 | Developer responsibility, §111 | Duty concerning design choices and affected communities | Sole liability or responsibility for every downstream outcome | No automatic downstream liability theorem |
| I10 | Compliance scope | Compliance relative to an enumerated requirement set and evidence context | Label an entire organization compliant from one decision | No global compliance conclusion from a local witness |
| I11 | Obligation satisfaction | `Required c r` and `Provided c r` are distinct | Add an explicit scoped compliance premise when deriving provision | No unqualified `Required → Provided` rule |
| I12 | Machine agency, §99 | Source-relative anthropological premise kept optional | Encode a universal metaphysical claim about every possible AI | Avoid excluding AI by type and calling that a discovery |
| I13 | Authority, §110 | Lack of entailment from capability alone in a named theory fragment | All capable actors lack legitimate authority | Stronger reading rejected as unsupported by the intended non-entailment claim |
| I14 | High-stakes autonomy | Compare prospective prevention with post-event repair in a hypothetical case | Infer a categorical weapons ban or perfect reparability | Extra source and semantic premises would be required |
| I15 | Decision-specific identification | Known staffing and internal case allocation remain separate facts | Every assigned case officer is identifiable | The staff contact and the case assignee can be different witnesses; formalized in public-benefits example |
| I16 | Responsibility and correction authority | Named assignment alone does not confer power | Assigned officer has authority for this decision | Model-level action capacity, not legal liability or successful repair; separate power premise |
| I17 | Correction versus restoration | In the high-stakes case, canCorrect concerns the decision record | Full physical restoration is a separate reachability property | No redefinition of record authority as complete remedy; the scope is explicit in recordCorrectionAllocation |
| I18 | Requested versus delivered control | Stop request and delivery are different events | Effective prevention needs delivery before the hazardous execution | Protocol assumption motivated by human control questions, not a textual claim that the source specifies this protocol |
| I19 | Irreversible-loss dynamics | Available modeled actions preserve physical loss once it occurs | A delivered stop blocks the modeled hazardous execution if loss has not already occurred | Both are explicit case assumptions; no universal physical, safety, or weapons theorem |
| I20 | Operational oversight capacity, §§106,108 | Recognized independent body with review capability and stated remit | Decision-level actionable oversight additionally requires intervention capacity for that same body and decision | A bounded proxy for one part of effectiveness; not actual exercise, timeliness, competence, participation or successful correction |

## Interpretation families

Begin with two responsibility variants (individual allocation / institutional answerability), two recourse variants (exclusion / broader impact), and two oversight variants (regime / decision). Do not assume every Cartesian combination is admissible. Admit a combination only after checking source fidelity and constructing a satisfaction witness.

Minimal-to-strong inheritance is an interface theorem. A substantive robustness result quantifies over the declared admissible family and identifies which conclusions survive the differences. Shared-premise projections do not count as discoveries.

## Prototype 0.3 evidence

The responsibility-only interpretations are explicit in Responsibility.lean. A known agency, known staff, and internal allocation do not imply an identifiable case-specific assignee: PublicBenefits.lean supplies a finite witness. Assignment coverage plus identifiability of assigned people is sufficient for individual answerability. This bridge is not claimed to be the weakest possible premise. A further, separate authority premise is sufficient for action capacity. No declaration establishes that the source uniquely chooses either interpretation.

## Prototype 0.4 evidence

HighStakes.lean compares two runs containing the same request, delivery, execution, and record-correction events in different orders. Final administrative flags agree; physical outcomes differ. Induction establishes loss persistence and the conditional guarantee for a loss-free state with an already-delivered stop, over all finite continuations allowed by this model. The protocol dynamics are assumptions of the hypothetical case, not imported obligations or empirical findings.

## Prototype 0.5: the two appeal readings

AppealReview.lean names a narrow policy (the existing responsibilityAppealPolicy) and a broader policy. The latter requires appeal for exclusion OR for high impact plus affectedness. This union preserves every original exclusion duty, including cases not separately classified as high-impact. No hidden implication from exclusion to impact is needed for refinement.

Both reject exclusion without an accessible appeal. This is a baseline rule consequence, not a new ethical discovery. A non-excluded but affected high-impact person with no appeal supplies a separating witness: the narrow appeal fragment is satisfied and the broad fragment is not. The exact added provision is characterized. Opening affected-person access repairs appeal compliance in both policies while internal review, assignment, and exclusion facts remain fixed.

The claimed shared conclusions concern these two named policies only. Broader source interpretation robustness, independent oversight, and full remedy obligations remain separate work.

## Prototype 0.6: oversight levels and powers

The official English text was rechecked on 2026-11-01: §106 calls for independent oversight; §108 calls for clear criteria and effective oversight in connection with public goods and fundamental rights, grounded in participation and subsidiarity. The exact per-decision reviewer arrangement is our interpretation, not a mechanism specified by those passages. No opacity-to-duty rule is inferred.

Oversight.lean separates recognition, independence, remit, review capability and intervention capacity. Its regime fragment is the explicit formula `∃ r, recognized r ∧ independent r ∧ canReview r`. The decision-level predicate ActionableIndependentOversight adds decision remit and intervention capacity for the same reviewer. The predicate is an operational capacity proxy, not a complete translation of source effectiveness. The source's criteria and participation conditions are not encoded by this slice.

The board exists and covers routine inquiries even when it cannot cover the denial; internal review of the denial does not close the independent-coverage gap. Extending the board's remit without intervention power still fails the actionable extension. The paired repairs isolate the two provisions. General sufficient bridges are explicit and are not claimed to be weakest possible premises. The cases retain the same high-impact denial, affected person, named assignment, appeal and remedy capacity, satisfying both the broad appeal and harm-remedy fragments throughout. This rules out an appeal-reading change as the cause of the oversight separation; it is not a robustness theorem for all combinations of source interpretations.
