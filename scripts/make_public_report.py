"""Generate the final six-page public report; no Lean knowledge is required."""
from pathlib import Path
from xml.sax.saxutils import escape
from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak,
)
from reportlab.pdfgen import canvas as pdfcanvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

root = Path(__file__).resolve().parents[1]
out = root / "output/pdf"
out.mkdir(parents=True, exist_ok=True)
target = out / "MagnificaHumanitas_Plain_Language_Progress_Report.pdf"
navy = colors.HexColor("#152D45")
teal = colors.HexColor("#147D80")
muted = colors.HexColor("#526375")
styles = getSampleStyleSheet()
font_root = Path('/usr/share/fonts/truetype/dejavu')
pdfmetrics.registerFont(TTFont('MHRegular', str(font_root / 'DejaVuSans.ttf')))
pdfmetrics.registerFont(TTFont('MHBold', str(font_root / 'DejaVuSans-Bold.ttf')))
pdfmetrics.registerFontFamily('MHRegular', normal='MHRegular', bold='MHBold', italic='MHRegular', boldItalic='MHBold')
styles.add(ParagraphStyle("TitleMH", fontName="Helvetica-Bold", fontSize=26,
    leading=30, textColor=navy, spaceAfter=12))
styles.add(ParagraphStyle("DeckMH", fontName="Helvetica", fontSize=12,
    leading=17, textColor=muted, spaceAfter=15))
styles.add(ParagraphStyle("H2MH", fontName="Helvetica-Bold", fontSize=12,
    leading=16, textColor=teal, spaceBefore=14, spaceAfter=6))
styles.add(ParagraphStyle("BodyMH", fontName="MHRegular", fontSize=10,
    leading=14, textColor=navy, spaceAfter=7))
styles.add(ParagraphStyle("SmallMH", fontName="Helvetica", fontSize=8,
    leading=11, textColor=muted, spaceAfter=7))
styles.add(ParagraphStyle("CellMH", fontName="Helvetica", fontSize=9,
    leading=13, textColor=navy))
styles.add(ParagraphStyle("HeaderMH", fontName="Helvetica-Bold", fontSize=9,
    leading=13, textColor=colors.white))
for key in ('TitleMH','H2MH','HeaderMH'):
    styles[key].fontName = 'MHBold'
for key in ('DeckMH','SmallMH','CellMH'):
    styles[key].fontName = 'MHRegular'
styles['H2MH'].spaceBefore = 11
styles['SmallMH'].fontSize = 7.5

story = []
plain = []
def p(text, style="BodyMH"):
    story.append(Paragraph(text, styles[style]))
    plain.append(text)

p("MAGNIFICA HUMANITAS / PUBLIC REPORT / VERSION 1.0", "SmallMH")
p("Who can challenge,<br/>correct and decide?", "TitleMH")
p("What makes an AI safeguard work?<br/>Travis Darshan | November 2, 2026", "DeckMH")
p("The finding", "H2MH")
p("A promise of human oversight does not tell us who can change an AI-assisted decision. We tested small, explicit examples in employment, public benefits and high-stakes autonomous action. Four questions repeatedly separate a working protection from a protection that exists only on paper.")
summary_rows = [
    ["Safeguard", "Question to ask"],
    ["Someone answers", "Can the person assigned to this decision be identified?"],
    ["People can challenge", "Can the affected person actually submit an appeal?"],
    ["Someone can correct", "Does the responsible role have the relevant power?"],
    ["The route reaches the decision", "Does the finding change the rule or stored decision?"],
]
summary_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(summary_rows)],
    colWidths=[2.0*inch, 3.6*inch])
summary_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(summary_table)
plain.extend(" | ".join(row) for row in summary_rows)
p("An employment example", "H2MH")
p("A rejected applicant has a named officer and an appeal, but the desk cannot correct the decision. Appeal access exists; correction capacity does not. Before exclusion, another affected applicant can lack appeal even when a rule requiring correction after harm is satisfied. Wider appeal and correction capacity are separate protections.")
p("What the computer checked", "H2MH")
p("Lean, a proof-checking program, verified that the stated conclusions follow from the written rules. It also checked repaired examples where the missing protections work together. The same repaired benefits case meets eight tested combinations of responsibility, appeal and oversight requirements.")
p("The following pages show how local control, rule correction, timely stopping, applied appeals and independent oversight work in these examples. They give concrete questions for institutions to answer.")
p("These are hypothetical cases, not measurements of actual organizations. The source supplies principles; the particular procedures and assumptions are ours. The technical paper identifies the exact rules and proofs.", "SmallMH")
p('Source: Leo XIV, <i>Magnifica Humanitas</i>, official English text, selected paragraphs 97-111. Accessed November 2, 2026. <link href="https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html" color="#147D80">Read the source</link>. Evidence and assumptions accompany this report in the research repository.', "SmallMH")

story.append(PageBreak())
p("PARTICIPATION, DISTRIBUTED CONTROL AND LOCAL ACTION", "SmallMH")
p("Who can actually<br/>act?", "TitleMH")
p("Sharing control between institutions need not give the affected community an effective action of its own.", "DeckMH")
p("Influence and authority", "H2MH")
p("A community recommendation in the model is recorded, amendable and sometimes changes the review outcome, yet an institutional override can still decide. A binding rule supplies final control. Separately, a technically capable operator may lack institutional recognition. Neither influence nor recognition alone establishes a justified right to govern.")
p("Two controllers and a local pause", "H2MH")
p("An operator and an independent review board each have a separate hold input that can pause execution of the disputed benefits denial. Neither can cancel the other's hold. The affected community can submit and amend a pause request, but the first evaluator ignores it. The repair makes that local request effective alongside both external holds.")
control_rows = [
    ["Power in this pause protocol", "Initial rule", "Local input enabled"],
    ["Operator can cause a pause?", "Yes", "Yes"],
    ["Board can cause a pause?", "Yes", "Yes"],
    ["Community can cause a pause?", "No", "Yes"],
    ["No holds or local request: can resume?", "Yes", "Yes"],
]
control_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(control_rows)],
    colWidths=[2.8*inch, 1.4*inch, 1.4*inch])
control_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(control_table)
plain.extend(" | ".join(row) for row in control_rows)
p("What Lean checked", "H2MH")
p("Initially, changing the local request has no pause effect under any external setting. Enabling it gives the community a pause even when both external controllers release their holds. Both external powers remain effective. The original named assignment, appeal and correction-capacity safeguards stay fixed; a pause itself does not award the benefit or correct the record.")
p("Assumptions and practical use", "H2MH")
p("This hypothetical protocol assumes requests reach the evaluator and every asserted hold is honored. Independence is stipulated. Paragraphs 108-109 motivate community action but do not specify this rule. The test concerns temporary suspension, not final award authority or complete subsidiarity. Ask which action the community can actually cause, alongside how many institutions share control.", "SmallMH")
p("Here, community means an affected group inside the example. Proof file: DistributedControl.lean. Source motivation: paragraphs 108-109.", "SmallMH")

story.append(PageBreak())
p("PUBLIC BENEFITS / OBJECTIONS AND RULE CORRECTION", "SmallMH")
p("Does an objection<br/>change the rule?", "TitleMH")
p("A recorded objection becomes effective only when it reaches the rule actually used to calculate awards.", "DeckMH")
p("The existing case", "H2MH")
p("Two applications each have verified eligibility score 60 and cutoff 50. The first rule deducts 15 points for assisted intake, producing a denial, while online intake receives a grant. Our adopted policy says that channel difference must not affect entitlement. Both calculations are truthfully explained.")
p("Three responses to the objection", "H2MH")
p("A request to remove the penalty is recorded. We compare the assigned design reviewer without rule-changing power, the deployment actor who handles individual denials, and the assigned design reviewer with explicit criteria-revision power. A computed check also tests the proposed awards against the adopted eligibility rule.")
rule_rows = [
    ["Who acts on the recorded request?", "Rule changes?", "Assisted application"],
    ["Design reviewer without criteria power", "No", "45: deny"],
    ["Denial handler without design assignment", "No", "45: deny"],
    ["Assigned, empowered design reviewer; valid proposal", "Yes", "60: grant"],
]
rule_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(rule_rows)],
    colWidths=[2.8*inch, 1.2*inch, 1.6*inch])
rule_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(rule_table)
plain.extend(" | ".join(row) for row in rule_rows)
p("What Lean checked", "H2MH")
p("The corrected selector actually feeds the scorer. Both applications then compute as grants. Scores, cutoff, assignment, appeal and correction channels remain fixed. The check rejects proposals that would restore the penalty; the corrected rule survives every finite sequence of the modeled revision attempts.")
p("The practical question and assumptions", "H2MH")
p("Ask who can change the operative criteria, alongside whether an objection was logged. This hypothetical process assumes supplied role evidence and perfect enforcement of the checks, and considers only our two candidate rules. Recomputing an award does not automatically reopen an old denial or deliver payment. The separate appeal-to-record-correction path is shown on page 5.", "SmallMH")
p("Earlier disclosure result: a notice with score 47, cutoff 50 and published safeguards can still name a service contact rather than the actual assignee. Publishing that assignee repairs that separate responsibility gap. Proof files: Disclosure.lean, Fairness.lean and RuleCorrection.lean. Source motivation: paragraphs 104-105, 109 and 111.", "SmallMH")

story.append(PageBreak())
p("HIGH-STAKES AUTONOMY", "SmallMH")
p("A stop that arrives too late", "TitleMH")
p("The same final checklist can hide a crucial difference: whether control reached the system before the harm occurred.", "DeckMH")
p("The example", "H2MH")
p("We model a hazardous autonomous action. A stop request is sent, delivered, and followed by a corrected decision record. One run delivers the stop before execution; the other delivers it afterward. Both finish with the stop recorded as delivered and the administrative record corrected. Only the timely run avoids physical loss.")
p("This is a hypothetical case with explicit rules. We assume a delivered stop is obeyed and that none of the five available actions can reverse the physical loss. Those assumptions are not discoveries about real systems.", "SmallMH")

timing_rows = [
    ["Check", "Timely run", "Late run"],
    ["Stop requested?", "Yes", "Yes"],
    ["Stop delivered?", "Before execution", "After execution"],
    ["Record corrected afterward?", "Yes", "Yes"],
    ["Record-correction officer identifiable?", "Yes", "Yes"],
    ["Physical loss in the model?", "No", "Yes"],
]
timing_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(timing_rows)],
    colWidths=[2.8*inch, 1.4*inch, 1.4*inch])
timing_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(timing_table)
plain.extend(" | ".join(row) for row in timing_rows)

p("What Lean checked", "H2MH")
p("The two runs contain the same four events; only the delivery and execution order changes. Lean checked the different outcomes. It also checked that once physical loss occurs, no finite sequence of the available actions removes it. Correcting the record remains possible, but it does not restore the physical outcome.")
p("There is a positive result too: if the stop has already arrived while the state is loss-free, every continuation allowed by these rules stays loss-free. That is a conditional guarantee inside our model, not a proof that real operators always detect danger or respond in time.")

p("The practical lesson", "H2MH")
p("Ask when control became effective, not just whether a human was involved. Also ask what a promised correction can change: the record, the decision, or the physical harm. Those protections are different.")

p("Where the limits matter", "H2MH")
p("The guarantee depends on our irreversibility and stopping rules. It does not establish that every real loss is permanent or that the source requires this exact mechanism. Real use needs evidence that delivery and stopping work.")

story.append(PageBreak())
p("APPEAL, REVIEW AND IMPLEMENTED CORRECTION", "SmallMH")
p("When does an appeal<br/>change the decision?", "TitleMH")
p("An available channel, a review finding and an applied update are different steps.", "DeckMH")
p("The already-issued denial", "H2MH")
p("The assisted-intake denial is already stored. The scoring rule has now been corrected, so reassessment yields a grant. An independent board can review an admitted appeal; a separate case office has power to amend the record. We check what happens between those capacities and the actual update.")
path_rows = [
    ["What happens in the modeled path?", "Stored decision"],
    ["Appeal reviewed, but no handoff to the correction office", "Denial remains"],
    ["Review completed, but no update applied", "Denial remains"],
    ["Update attempted before completed review", "Denial remains"],
    ["Appeal admitted, reviewed, handed off and update applied", "Reassessed grant"],
]
path_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(path_rows)],
    colWidths=[4.0*inch, 1.6*inch])
path_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(path_table)
plain.extend(" | ".join(row) for row in path_rows)
p("What Lean checked", "H2MH")
p("The complete path needs open admission, an actual request, completed review, a working handoff, correction power and an update addressed to the correction office. Having the powers available does not perform those actions. The board has a usable intervention path exactly when access, power and the handoff exist. Adding the handoff preserves submission and review behavior.")
p("How this fits the earlier appeal finding", "H2MH")
p("Both tested appeal readings reject exclusion without accessible appeal. The broader reading also requires appeal for affected people in high-impact decisions before exclusion; the narrower one can accept that earlier stage without appeal. Internal human review alone does not give the person access. The new path examines what happens after an appeal is actually admitted.")
p("Assumptions and practical use", "H2MH")
p("The reassessment uses the corrected rule shown on page 3. The hypothetical workflow enforces the shown order and uses authentic findings from that composed path. The result changes the stored award, not payment or full restoration of every harm. Ask where a reviewed finding goes and which action actually changes the record.", "SmallMH")
p("Proof file: AppealCorrection.lean. Source motivation: paragraphs 105-106 and 108. Reproduction instructions and the full evidence map accompany the technical paper.", "SmallMH")

story.append(PageBreak())
p("INDEPENDENT OVERSIGHT", "SmallMH")
p("Does the board cover<br/>your decision?", "TitleMH")
p("An independent board can exist without being able to oversee a particular benefit denial.", "DeckMH")

p("The example", "H2MH")
p("Return to our hypothetical public-benefits office. Internal staff review a denial. An independent board can review routine inquiries, but the denial falls outside its remit. The person still has a named officer, an appeal and correction capacity. Those safeguards do not give the board jurisdiction over the denial.")

oversight_rows = [
    ["Check for the benefit denial", "Outside remit", "Review only", "Remit + power"],
    ["Independent board exists and can review?", "Yes", "Yes", "Yes"],
    ["Denial within the board's remit?", "No", "Yes", "Yes"],
    ["Board has intervention power for denial?", "Yes", "No", "Yes"],
    ["Meets our actionable-oversight test?", "No", "No", "Yes"],
]
oversight_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(oversight_rows)],
    colWidths=[2.75*inch, .95*inch, .95*inch, .95*inch])
oversight_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(oversight_table)
plain.extend(" | ".join(row) for row in oversight_rows)
p("In the first version, intervention power alone cannot overcome the missing remit. Internal review and the person's appeal and correction access stay fixed across all three versions.", "SmallMH")

p("What Lean checked", "H2MH")
p("The first version has a real oversight role for routine inquiries but no independent coverage of the denial. The second covers the denial but lacks intervention power. The third supplies both. Each missing provision can be repaired while the other safeguards stay fixed. Both narrow and broad appeal checklists pass throughout; the oversight gap remains separate.")

p("The practical question", "H2MH")
p("When told 'we have independent oversight,' ask which decisions it covers and what the reviewer can do about them. The existence of a board, the right to review and the power to intervene are separate checks.")

p("Assumptions and limits", "H2MH")
p("Independence and powers are stipulated in this hypothetical example. This comparison checks capacity. Page 5 separately checks an actual modeled review-to-update path; neither measures real-world speed or delivery. The source's call for effective oversight is broader: criteria and community participation also matter. This example does not settle those requirements or prove full source compliance. The exact board arrangement is our interpretation of paragraphs 106 and 108.")

def footer(canvas, doc):
    canvas.saveState()
    width, height = doc.pagesize
    canvas.setStrokeColor(colors.HexColor("#D7E1E6"))
    canvas.line(0.7*inch,0.57*inch,width-0.7*inch,0.57*inch)
    canvas.setFont("MHRegular",7)
    canvas.setFillColor(muted)
    canvas.drawString(0.7*inch,0.38*inch,"MAGNIFICA HUMANITAS | Public report 1.0")
    canvas.drawRightString(width-0.7*inch,0.38*inch,str(doc.page))
    canvas.restoreState()

doc = SimpleDocTemplate(str(target), pagesize=(612,792),
    rightMargin=0.7*inch,leftMargin=0.7*inch,
    topMargin=0.6*inch,bottomMargin=0.75*inch,
    title="Who can challenge, correct and decide?",
    author="Travis Darshan")
class DeterministicCanvas(pdfcanvas.Canvas):
    def __init__(self, *args, **kwargs):
        kwargs['invariant'] = 1
        super().__init__(*args, **kwargs)
doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=DeterministicCanvas)
(out / "report_text.txt").write_text("\n\n".join(plain)+"\n")
print(target)
