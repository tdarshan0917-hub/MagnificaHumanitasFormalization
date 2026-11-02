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

p("MAGNIFICA HUMANITAS / RESEARCH PROTOTYPE 0.11", "SmallMH")
p("Who can challenge,<br/>correct and decide?", "TitleMH")
p("What our computer-checked examples show<br/>Progress report | November 1, 2026", "DeckMH")
p("The finding", "H2MH")
p("Our checked examples separate responsibility, appeal, correction power, control, oversight, participation and disclosure. A published commitment is not its fulfillment. A known contact may not be the case assignee, an eventual stop may arrive too late, and technical control may exist without a recognized mandate. Each finding depends on stated rules and assumptions.")

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
p("PARTICIPATION, TECHNICAL CONTROL AND RECOGNITION", "SmallMH")
p("Who has the<br/>last word?", "TitleMH")
p("Influence, technical control and recognition are different.", "DeckMH")

p("The participation finding", "H2MH")
p("A community's recommendation about the hypothetical denial is recorded and amendable. Without an override, changing it changes the result. An institutional override can still select either result, so influence does not supply final control or a veto. Making the recommendation binding supplies control while acceptance, recording and amendment stay fixed.")

p("Now: control and a recognized mandate", "H2MH")
p("An operator can use the bounded review rule to produce either result. In one version, the institution does not recognize that operator for the denial. In the other, it does. The operator's technical powers stay the same. An independent, recognized board remains available in both versions, alongside the person's appeal and correction safeguards.")

authority_rows = [
    ["Check for the operator", "Unrecognized", "Recognized"],
    ["Can produce either review outcome?", "Yes", "Yes"],
    ["Institution recognizes operator for this denial?", "No", "Yes"],
    ["Independent board remains available?", "Yes", "Yes"],
]
authority_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(authority_rows)],
    colWidths=[3.0*inch, 1.3*inch, 1.3*inch])
authority_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(authority_table)
plain.extend(" | ".join(row) for row in authority_rows)

p("What follows - and what does not", "H2MH")
p("Technical control does not supply institutional recognition here. A capable, recognized operator is also possible. Recognition remains a separate fact, not proof of moral or legal legitimacy. The wider authority question is unresolved.")

p("The practical question", "H2MH")
p("Ask what people can change, who can overrule them, who recognizes the decision-maker and what justifies that authority. Having a voice, having technical control and having a justified right to decide require different evidence.")

p("Limits and unfinished work", "H2MH")
p("These hypothetical rules stipulate recording, amendment and recognition; they do not establish full subsidiarity or legitimacy. Paragraphs 107-110 motivate the questions. This is a progress report. The remaining original Lean targets are active; final writing and release follow that work.")

story.append(PageBreak())
p("PUBLIC BENEFITS / ETHICS COMMITMENTS AND DISCLOSURE", "SmallMH")
p("Who answers<br/>for this denial?", "TitleMH")
p("A truthful explanation and published promises can leave the actual case officer unidentified.", "DeckMH")

p("Earlier responsibility checks", "H2MH")
p("Earlier proofs separate service contacts, actual assignees and correction power, and design-stage from later-use assignments. In the delegation test, an AI producer change preserved existing duties; additionally removing the human officer violated them.")

p("The public notice", "H2MH")
p("The notice promises identifiable responsibility, appeal and correction capacity. It reports score 47, cutoff 50 and the denial computed by that rule. A genuine public contact is named, but that person handles inquiries. A different, unidentified employee handles the denial.")
p("This is a hypothetical office with explicit records and a stipulated scoring rule, not an audited agency.", "SmallMH")

disclosure_rows = [
    ["Check in the public-benefits case", "Contact only", "Assignee added"],
    ["Same published commitments?", "Yes", "Yes"],
    ["Correct score/cutoff explanation?", "Yes", "Yes"],
    ["Genuine named service contact?", "Yes", "Yes"],
    ["Actual case assignee identified?", "No", "Yes"],
    ["Meets the announced checklist?", "No", "Yes"],
]
disclosure_table = Table([
    [Paragraph(escape(v), styles["HeaderMH" if i == 0 else "CellMH"])
     for v in row] for i, row in enumerate(disclosure_rows)],
    colWidths=[3.0*inch, 1.3*inch, 1.3*inch])
disclosure_table.setStyle(TableStyle([
    ("BACKGROUND", (0,0), (-1,0), navy),
    ("ROWBACKGROUNDS", (0,1), (-1,-1), [colors.HexColor("#EFF5F6"), colors.white]),
    ("VALIGN", (0,0), (-1,-1), "TOP"),
    ("LEFTPADDING", (0,0), (-1,-1), 7),
    ("RIGHTPADDING", (0,0), (-1,-1), 7),
    ("TOPPADDING", (0,0), (-1,-1), 7),
    ("BOTTOMPADDING", (0,0), (-1,-1), 7),
]))
story.append(disclosure_table)
plain.extend(" | ".join(row) for row in disclosure_rows)

p("What Lean checked", "H2MH")
p("The numerical explanation checks out, the listed contact is identifiable and the policy names the required safeguards. Yet the actual assignee is unidentified, so the responsibility requirement fails. Publishing that assignee repairs the gap while internal allocation, promises, numbers, appeal and correction capacity stay fixed.")

p("The practical question and the limit", "H2MH")
p("Ask who is assigned to this decision, alongside the help desk and score explanation. The minimal disclosure standard permits a service contact; a stronger actual-assignee requirement rejects the first notice. The case proves neither fairness nor data quality or full source compliance. Paragraphs 105-106 motivate the question.")
p("Proof file: Disclosure.lean. Remaining agreed targets stay active.", "SmallMH")

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
