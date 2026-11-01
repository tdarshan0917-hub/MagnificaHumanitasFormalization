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

p("MAGNIFICA HUMANITAS / RESEARCH PROTOTYPE 0.2", "SmallMH")
p("An appeal is not the<br/>same as a remedy", "TitleMH")
p("What our first computer-checked example shows<br/>Progress report | November 1, 2026", "DeckMH")
p("The finding", "H2MH")
p("A person may receive an explanation, have a named responsible officer, and be allowed to appeal an AI-assisted decision - yet the review office may still lack the power to correct it. Our first Lean example checks that these arrangements can coexist under a limited set of written rules.")

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

story.append(PageBreak())
p("WHAT WE CHECKED - AND WHAT WE HAVE NOT", "SmallMH")
p("Keeping the promises separate", "TitleMH")
p("What the computer checked", "H2MH")
p("Lean checked our proofs about the two versions of the example. The first meets our responsibility-and-appeal checklist but fails the checklist that also requires correction capacity. The second meets both. We also supplied a case that meets the stronger checklist while still having an affected person and a harmful, high-impact decision. The requirements can therefore be met together in this small model.")
p("A further check keeps a duty separate from its fulfillment. A rule can require correction capacity even when the organization does not provide it. The missing safeguard is then a violation of that rule; writing the rule did not make the safeguard appear.")

p("The assumptions behind the result", "H2MH")
for text in [
    "The example has one applicant, one decision, one officer, and one appeal desk.",
    "We stipulate that the decision is consequential, excludes the applicant, and causes harm.",
    "An accessible desk with review power counts as an appeal channel.",
    "An accessible desk with correction power counts as correction capacity. This does not promise that every loss can be undone.",
    "The two checklists are our explicit working interpretations. They represent only a small part of the source document.",
]:
    p("<b>-</b> " + text)

p("How this relates to the encyclical", "H2MH")
p("The source discussion of appeal and responsibility motivates the questions we test. Our choice to represent remedy through correction capacity is an interpretation that must remain open to scrutiny. Lean checks the consequences of our written rules; it cannot decide that our reading is the only correct reading.")

p("The honest limit of this first result", "H2MH")
p("This is a simple example, not yet a major new finding about AI governance. It shows that the method works and that we can expose a missing safeguard without quietly assuming it exists. We have not established that a real AI system is safe, fair, legally compliant, or ethically justified. We have not formalized the whole encyclical.")

p("What comes next", "H2MH")
p("We will test responsibility, appeal, and correction in the three agreed cases: employment, public benefits, and high-stakes autonomous decisions. We will compare reasonable readings of the source and keep useful examples where a proposed guarantee fails. The final project must include a separate plain-language report explaining its findings, assumptions, and practical limits. Completing the code alone will not complete the project.")

p('Source: official English Vatican text, <i>Magnifica Humanitas</i>, selected paragraphs 97-111; prototype references 103-105. Accessed November 1, 2026. <link href="https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html" color="#147D80">Read the source</link>. Technical evidence: project verification logs and docs/TECHNICAL_RESULTS.md.', "SmallMH")

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
    title="An appeal is not the same as a remedy",
    author="Magnifica Humanitas Formalization research project")
doc.build(story,onFirstPage=footer,onLaterPages=footer)
(out / "report_text.txt").write_text("\n\n".join(plain)+"\n")
print(target)
