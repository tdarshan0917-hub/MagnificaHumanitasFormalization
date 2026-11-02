"""Render the approved five-page, 22-paragraph public report from its manuscript."""
import json
from pathlib import Path
from xml.sax.saxutils import escape
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas as pdfcanvas
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, KeepTogether

ROOT=Path(__file__).resolve().parents[1]
D=json.loads((ROOT/'paper/public_report.json').read_text())
OUT=ROOT/'output/pdf';OUT.mkdir(parents=True,exist_ok=True)
FONTS=Path('/usr/share/fonts/truetype/dejavu')
for name,file in [('MH','DejaVuSans.ttf'),('MHB','DejaVuSans-Bold.ttf')]:
    pdfmetrics.registerFont(TTFont(name,str(FONTS/file)))
pdfmetrics.registerFontFamily('MH',normal='MH',bold='MHB',italic='MH',boldItalic='MHB')
NAVY,TEAL,MUTED=[colors.HexColor(x) for x in ['#152D45','#147D80','#526375']]
S={
 'kicker':ParagraphStyle('kicker',fontName='MHB',fontSize=7.5,leading=11,textColor=TEAL,spaceAfter=8),
 'title':ParagraphStyle('title',fontName='MHB',fontSize=23,leading=27,textColor=NAVY,spaceAfter=8),
 'section':ParagraphStyle('section',fontName='MHB',fontSize=18,leading=23,textColor=NAVY,spaceAfter=7),
 'deck':ParagraphStyle('deck',fontName='MH',fontSize=9.5,leading=13,textColor=MUTED,spaceAfter=12),
 'body':ParagraphStyle('body',fontName='MH',fontSize=10,leading=13,textColor=NAVY,spaceAfter=8),
 'notes':ParagraphStyle('notes',fontName='MH',fontSize=7.2,leading=10,textColor=MUTED,spaceBefore=4,spaceAfter=3),
}
def textpara(t,style='body'):
 return Paragraph(t,S[style])
story=[]
md=[f"# {D['title']}",D['subtitle'],f"{D['author']} | {D['date']} | Public report {D['version']}"]
plain=[]
for i,page in enumerate(D['pages'],1):
 if i>1:story.append(PageBreak())
 story.append(textpara(f'MAGNIFICA HUMANITAS / PUBLIC REPORT {D["version"]} / {i} OF 5','kicker'))
 if i==1:
  story.append(textpara(escape(D['title']),'title'))
  story.append(textpara(escape(D['subtitle'])+'<br/>'+escape(D['author']+' | '+D['date']),'deck'))
  story.append(textpara('1. '+escape(page['title']),'section'))
 else:
  story.append(textpara(str(i)+'. '+escape(page['title']),'section'))
  story.append(textpara(escape(page['deck']),'deck'))
 md.append('## '+page['title']);plain.append(page['title'])
 for p in page['paragraphs']:
  # Exactly one body Paragraph per approved outline paragraph.
  story.append(textpara('<b>'+escape(p['label'])+'.</b> '+escape(p['text'])))
  md.append('**'+p['label']+'.** '+p['text']);plain.append(p['label']+'. '+p['text'])
 story.append(Spacer(1,3))
 story.append(textpara(escape(page['notes']),'notes'))

 md.append('*'+page['notes']+'*');md.append('[Official English source PDF]('+D['source_url']+')')

def footer(c,doc):
 c.saveState();c.setStrokeColor(colors.HexColor('#D7E1E6'));c.line(45,41,550.276,41)
 c.setFillColor(MUTED);c.setFont('MH',7)
 c.drawString(45,27,'MAGNIFICA HUMANITAS | Public report 1.1')
 c.setFillColor(TEAL);c.drawString(350,27,'Source PDF');c.drawString(425,27,'Evidence')
 c.linkURL(D['source_url'],(350,24,395,36),relative=0)
 c.linkURL('https://github.com/tdarshan0917-hub/MagnificaHumanitasFormalization',(425,24,465,36),relative=0)
 c.setFillColor(MUTED)
 c.drawRightString(550.276,27,f'{doc.page} / 5');c.restoreState()
class DeterministicCanvas(pdfcanvas.Canvas):
 def __init__(self,*a,**k):k['invariant']=1;super().__init__(*a,**k)
target=OUT/'MagnificaHumanitas_Plain_Language_Progress_Report.pdf'
doc=SimpleDocTemplate(str(target),pagesize=(595.276,841.89),leftMargin=45,rightMargin=45,topMargin=35,bottomMargin=54,title=D['title'],author=D['author'],subject=D['subtitle'])
doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=DeterministicCanvas)
(ROOT/'docs/PUBLIC_REPORT.md').write_text('\n\n'.join(md)+'\n')
(OUT/'report_text.txt').write_text('\n\n'.join(plain)+'\n')
print(target)
