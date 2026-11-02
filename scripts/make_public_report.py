"""Generate the short public progress report; no Lean knowledge is required."""
from pathlib import Path
from xml.sax.saxutils import escape
from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak,
)
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

p("MAGNIFICA HUMANITAS / RESEARCH PROTOTYPE 0.13", "SmallMH")
p("Who can challenge,<br/>correct and decide?", "TitleMH")
p("What our computer-checked examples show<br/>Progress report | November 1, 2026", "DeckMH")
p("The finding", "H2MH")
p("Our examples distinguish responsibility, appeal, correction power, control, oversight, participation, disclosure and fairness. A published promise need not be fulfilled; a named contact need not be the case officer; a delivered stop can arrive too late. A truthful calculation can reveal an unfair rule under a stated policy. Each result depends on explicit assumptions.")

p("A simple employment example", "H2MH")
p("Imagine that an AI-assisted hiring decision rejects an applicant and causes harm. A named officer is responsible. The applicant can send an appeal to a desk that can reconsider the decision. In the first version, that desk has no power to correct it. In the second version, we give the desk correction power. Everything else in the example stays the same.")
p("This is a hypothetical case. We have not investigated a real employer or measured harm to actual applicants.", "SmallMH")

cells = [
    ["Safeguard in our example", "First version", "Changed version"],
    ["Named responsible officer", "Yes", "Yes"],
    ["Explanation and human review", "Yes", "Yes"],
    ["Accessible appeal", "Yes", "Yes"],
    ["Power to correct", "No", "Yes"],
    ["Meets responsibility-and-appeal checklist", "Yes", "Yes"],
    ["Meets checklist also requiring correction capacity", "No", "Yes"],
]
table = Table([[Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
    for v in row] for i, row in enumerate(cells)], colWidths=[3.35*inch, 1.0*inch, 1.25*inch])
table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 9),
    ("RIGHTPADDING", (0,0), (-1,-1), 9),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
    ("LINEBELOW", (0,-1), (-1,-1), 0.6, colors.HexColor("#CDDADF")),
]))
story.append(table)
plain.extend(" | ".join(row) for row in cells)
p("Why this matters", "H2MH")
p("When assessing an AI appeal process, ask two separate questions: Can the person get a review? Can someone correct the decision if that review finds an error? A positive answer to the first question does not supply the second.")

p("These hypothetical models check consequences of stated rules. They do not establish a uniquely correct source reading, real-institution compliance or major research novelty. Several original targets remain active; the Lean research programme is unfinished. A written duty does not provide its safeguard.", "SmallMH")
p('Source: official English Vatican text, <i>Magnifica Humanitas</i>, selected paragraphs 97-111. Accessed November 1, 2026. <link href="https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html" color="#147D80">Read the source</link>. Evidence and assumptions: docs/TECHNICAL_RESULTS.md and project verification logs.', "SmallMH")

story.append(PageBreak())
p("PARTICIPATION, DISTRIBUTED CONTROL AND LOCAL ACTION", "SmallMH")
p("Who can actually<br/>act?", "TitleMH")
p("Sharing control between institutions need not give a community an effective action of its own.", "DeckMH")
p("Earlier: influence and authority", "H2MH")
p("Our earlier community recommendation is recorded, amendable and sometimes changes the review outcome, yet an institutional override can still decide. A binding rule supplies final control. Separately, a technically capable operator may lack institutional recognition. Neither influence nor recognition alone establishes a justified right to govern.")
p("Now: two controllers and a local pause", "H2MH")
p("An operator and an independent review board each have a separate hold input that can pause execution of the disputed benefits denial. Neither can cancel the other's hold. The community can submit and amend a pause request, but the first evaluator ignores it. The repair makes that local request effective alongside both external holds.")
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
p("Proof file: DistributedControl.lean. Remaining positive-target questions are active before final writing and release.", "SmallMH")

story.append(PageBreak())
p("PUBLIC BENEFITS / DISCLOSURE AND FAIRNESS", "SmallMH")
p("Explained,<br/>but fair?", "TitleMH")
p("A correct calculation can reveal a rule that violates an independently adopted fairness standard.", "DeckMH")
p("The earlier disclosure finding", "H2MH")
p("Our earlier notice reports score 47, cutoff 50 and a computed denial. It promises responsibility, appeal and correction capacity, yet names a service contact rather than the actual case officer. Identifying that already-assigned officer repairs the responsibility gap without changing the promises, numbers or channels. A stricter disclosure rule could demand that identity from the outset.")
p("The new fairness test", "H2MH")
p("Now consider two fully verified applications, each with eligibility score 60 and cutoff 50. One arrives online; the other uses an assisted service desk. Our adopted case policy says intake channel must not change entitlement. The first scoring rule nevertheless deducts 15 points for assisted intake. Both notices disclose the deduction and correctly explain their results.")
fairness_rows = [
    ["Application", "Initial rule", "Penalty removed"],
    ["Online: verified score 60", "60 - 0: grant", "60 - 0: grant"],
    ["Assisted: verified score 60", "60 - 15: deny", "60 - 0: grant"],
    ["Both calculations explained?", "Yes", "Yes"],
    ["Both adopted fairness tests pass?", "No", "Yes"],
]
fairness_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(fairness_rows)],
    colWidths=[2.8*inch, 1.4*inch, 1.4*inch])
fairness_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(fairness_table)
plain.extend(" | ".join(row) for row in fairness_rows)
p("What Lean checked", "H2MH")
p("The first rule fails equal treatment across these channels and fails to apply the cutoff to the verified base score. Removing the penalty supplies both tests. Identified assignment, appeal and correction-capacity checklists pass in both versions; the channels stay fixed. Their availability does not establish that a correction occurred.")
p("Assumptions and practical use", "H2MH")
p("Equal eligibility and channel irrelevance are explicit hypothetical policy assumptions. Paragraphs 104 and 109 motivate scrutiny of design choices; they do not prescribe our scoring formula. This tests a local fairness rule, not all justice. Ask whether the explained features are justified, alongside whether the arithmetic is correct. Remaining agreed targets stay active.", "SmallMH")
p("Proof files: Disclosure.lean and Fairness.lean. No actual agency was audited.", "SmallMH")

story.append(PageBreak())
p("NEW RESULT / HIGH-STAKES AUTONOMY", "SmallMH")
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
p("The result depends on the stated irreversibility and stop rules. It does not establish that every real loss is permanent or that the encyclical uniquely requires this particular mechanism. We have initial examples in all three agreed case domains; the full research project remains unfinished.")

story.append(PageBreak())
p("NEW RESULT / APPEAL AND REVIEW", "SmallMH")
p("Who gets to appeal?", "TitleMH")
p("An internal review does not itself give the affected person an appeal. The duty's starting point matters.", "DeckMH")

p("Two explicit readings", "H2MH")
p("The narrow reading requires appeal after exclusion. The broader reading keeps that rule and adds appeal for an affected person in a consequential decision, even before exclusion. These are two working interpretations; we do not claim they exhaust the source's possible readings.")

appeal_rows = [
    ["Hypothetical situation", "Narrow checklist", "Broad checklist"],
    ["Person excluded; no accessible appeal", "Fails", "Fails"],
    ["Consequential decision affects person; no exclusion yet; no appeal", "Passes", "Fails"],
    ["Person excluded; accessible appeal provided", "Passes", "Passes"],
]
appeal_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(appeal_rows)],
    colWidths=[3.0*inch, 1.3*inch, 1.3*inch])
appeal_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 8),
    ("BOTTOMPADDING", (0,0), (-1,-1), 8),
]))
story.append(appeal_table)
plain.extend(" | ".join(row) for row in appeal_rows)
p("Named responsibility and internal review stay fixed. 'Passes' means only this limited checklist; neither policy includes a remedy-capacity duty.", "SmallMH")

p("What survives both readings", "H2MH")
p("Both reject exclusion without an accessible appeal. This is a checked consequence of the shared rule, not a new moral discovery. Staff review may occur internally while the person has no channel to challenge. After exclusion, that arrangement fails both checklists.")

p("Where the readings differ", "H2MH")
p("An AI-assisted ranking can affect opportunities before exclusion. Without appeal, the narrow checklist can pass and the broader one fails. Its extra guarantee comes from the added duty. Opening person access satisfies both appeal checklists while review and assignment stay fixed.")

p("The practical question", "H2MH")
p("When an organization says 'a human reviews our AI decisions,' ask whether the affected person can challenge, and when that opportunity begins. Review, person access, and the duty's trigger are separate issues.")

p("Assumptions and limits", "H2MH")
p("These are hypothetical employment-style cases. High impact and affectedness are stipulated; actual harm is not assumed. The broader duty is explicit. Appeal alone does not establish remedy capacity, restoration, or full source compliance. The remaining agreed research questions are still unfinished.")

story.append(PageBreak())
p("NEW RESULT / INDEPENDENT OVERSIGHT", "SmallMH")
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
p("Independence and powers are stipulated in this hypothetical example. Our test checks capacity, not actual action, speed or successful correction. The source's call for effective oversight is broader: criteria and community participation also matter. This example does not settle those requirements or prove full source compliance. The exact board arrangement is our interpretation of paragraphs 106 and 108.")

def footer(canvas, doc):
    canvas.saveState()
    width, height = doc.pagesize
    canvas.setStrokeColor(colors.HexColor("#D7E1E6"))
    canvas.line(0.7*inch,0.57*inch,width-0.7*inch,0.57*inch)
    canvas.setFont("MHRegular",7)
    canvas.setFillColor(muted)
    canvas.drawString(0.7*inch,0.38*inch,"MAGNIFICA HUMANITAS | Plain-language progress report")
    canvas.drawRightString(width-0.7*inch,0.38*inch,str(doc.page))
    canvas.restoreState()

doc = SimpleDocTemplate(str(target), pagesize=(612,792),
    rightMargin=0.7*inch,leftMargin=0.7*inch,
    topMargin=0.6*inch,bottomMargin=0.75*inch,
    title="Who can challenge, correct and decide?",
    author="Magnifica Humanitas Formalization research project")
doc.build(story,onFirstPage=footer,onLaterPages=footer)
(out / "report_text.txt").write_text("\n\n".join(plain)+"\n")
print(target)
