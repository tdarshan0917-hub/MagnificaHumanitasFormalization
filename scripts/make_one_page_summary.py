"""Render the one-page public entry point from its structured source."""
import json
from pathlib import Path
from xml.sax.saxutils import escape
import reportlab
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.pdfgen import canvas
from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer,Table,TableStyle
from report_graphics import correction_diagram,export_diagram

ROOT=Path(__file__).resolve().parents[1];D=json.loads((ROOT/'paper/one_page_summary.json').read_text())
FONT=Path('/usr/share/fonts/truetype/dejavu')
for name,file in [('MH','DejaVuSans.ttf'),('MHB','DejaVuSans-Bold.ttf')]:pdfmetrics.registerFont(TTFont(name,str(FONT/file)))
pdfmetrics.registerFontFamily('MH',normal='MH',bold='MHB')
NAVY,TEAL,MUTED=[colors.HexColor(x) for x in ['#152D45','#147D80','#526375']]
W=505.276
S={
 'kicker':ParagraphStyle('k',fontName='MHB',fontSize=7.5,leading=10,textColor=TEAL,spaceAfter=7),
 'title':ParagraphStyle('t',fontName='MHB',fontSize=20,leading=24,textColor=NAVY,spaceAfter=6),
 'sub':ParagraphStyle('s',fontName='MH',fontSize=9.1,leading=12,textColor=MUTED,spaceAfter=4),
 'body':ParagraphStyle('b',fontName='MH',fontSize=9.8,leading=13,textColor=NAVY,spaceAfter=6),
 'heading':ParagraphStyle('h',fontName='MHB',fontSize=10,leading=13,textColor=TEAL,spaceBefore=3,spaceAfter=4),
 'note':ParagraphStyle('n',fontName='MH',fontSize=7.4,leading=10,textColor=MUTED,spaceAfter=4),
 'cell':ParagraphStyle('c',fontName='MH',fontSize=8.4,leading=10.7,textColor=NAVY),
 'head':ParagraphStyle('hc',fontName='MHB',fontSize=8.4,leading=10.7,textColor=colors.white),
}
def p(s,key='body'):return Paragraph(s,S[key])
story=[p('MAGNIFICA HUMANITAS / RELEASE '+D['release']+' / ONE-PAGE SUMMARY','kicker'),p(escape(D['title']),'title'),p(escape(D['author']+' | '+D['date']),'sub'),p(escape(D['ai_credit']),'note'),p('Release DOI: <link href="'+D['doi_url']+'">'+escape(D['doi'])+'</link>','note'),p('<b>The study.</b> '+escape(D['purpose'])),p('<b>What Lean does.</b> '+escape(D['lean'])),p('<b>The example.</b> '+escape(D['story'])),p('Three findings to keep in view','heading')]
for finding in D['findings']:story.append(p('&#8226; '+escape(finding)))
story.extend([p(escape(D['diagram_heading']),'heading'),correction_diagram(W),Spacer(1,6)])
rows=[D['table_headers']]+D['table_rows']
t=Table([[p(escape(x),'head' if i==0 else 'cell') for x in row] for i,row in enumerate(rows)],colWidths=[123,W-123])
t.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),NAVY),('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.HexColor('#EFF5F6'),colors.white]),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),6),('RIGHTPADDING',(0,0),(-1,-1),6),('TOPPADDING',(0,0),(-1,-1),4),('BOTTOMPADDING',(0,0),(-1,-1),4)]))
story.extend([t,Spacer(1,7),p('<b>Read with this limit.</b> '+escape(D['limits']),'note'),p('Full reports and source package: <link href="'+D['doi_url']+'">'+escape(D['doi_url'])+'</link>','note')])
def footer(c,doc):
 c.setStrokeColor(colors.HexColor('#D7E1E6'));c.line(45,40,550.276,40)
 c.setFillColor(MUTED);c.setFont('MH',7);c.drawString(45,26,'RELEASE '+D['release']+' | Summary '+D['version'])
 c.setFillColor(TEAL);c.drawString(430,26,'Official source');c.linkURL(D['source_url'],(430,23,500,35),relative=0)
 c.setFillColor(MUTED);c.drawRightString(550.276,26,'1 / 1')
class FixedCanvas(canvas.Canvas):
 def __init__(self,*a,**k):k['invariant']=1;super().__init__(*a,**k)
out=ROOT/'output/pdf/MagnificaHumanitas_One_Page_Summary.pdf'
doc=SimpleDocTemplate(str(out),pagesize=(595.276,841.89),leftMargin=45,rightMargin=45,topMargin=33,bottomMargin=52,title=D['title'],author=D['author'],subject=D['subtitle'])
doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=FixedCanvas)
md=['# '+D['title'],D['author']+' | '+D['date'],'Release '+D['release'],'Release DOI: '+D['doi_url'],D['purpose'],'## What Lean does',D['lean'],'## The example',D['story'],'## Three findings to keep in view','\n'.join('- '+f for f in D['findings']),'## '+D['diagram_heading'],'![Decision-to-correction route](../output/figures/decision_to_correction.svg)',D['diagram_caption'],'## Institutional checks','\n'.join([' | '.join(D['table_headers']),'--- | ---']+[' | '.join(r) for r in D['table_rows']]),'## Reading the evidence',D['limits'],D['evidence_note'],D['ai_credit']]
(ROOT/'docs/ONE_PAGE_SUMMARY.md').write_text('\n\n'.join(md)+'\n')
export_diagram(ROOT)
print(out)
