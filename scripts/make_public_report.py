"""Render the integrated public report, including summary, blueprint and acknowledgment."""
import json
import reportlab
from pathlib import Path
from xml.sax.saxutils import escape
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas as pdfcanvas
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, Table, TableStyle

ROOT=Path(__file__).resolve().parents[1]
D=json.loads((ROOT/'paper/public_report.json').read_text())
OUT=ROOT/'output/pdf';OUT.mkdir(parents=True,exist_ok=True)
TOTAL=len(D['pages']);WIDTH=505.276
FONTS=Path('/usr/share/fonts/truetype/dejavu')
for name,file in [('MH','DejaVuSans.ttf'),('MHB','DejaVuSans-Bold.ttf'),('MHI','DejaVuSans-Oblique.ttf')]:
 font_path=FONTS/file
 if name=='MHI' and not font_path.exists():font_path=Path(reportlab.__file__).resolve().parent/'fonts/VeraIt.ttf'
 pdfmetrics.registerFont(TTFont(name,str(font_path)))
pdfmetrics.registerFontFamily('MH',normal='MH',bold='MHB',italic='MHI',boldItalic='MHB')
NAVY,TEAL,MUTED=[colors.HexColor(x) for x in ['#152D45','#147D80','#526375']]
S={
 'kicker':ParagraphStyle('kicker',fontName='MHB',fontSize=7.5,leading=11,textColor=TEAL,spaceAfter=8),
 'title':ParagraphStyle('title',fontName='MHB',fontSize=23,leading=27,textColor=NAVY,spaceAfter=7),
 'section':ParagraphStyle('section',fontName='MHB',fontSize=18,leading=23,textColor=NAVY,spaceAfter=7),
 'deck':ParagraphStyle('deck',fontName='MH',fontSize=9.5,leading=13,textColor=MUTED,spaceAfter=12),
 'subtitle':ParagraphStyle('subtitle',fontName='MH',fontSize=9.2,leading=12.5,textColor=MUTED,spaceAfter=5),
 'byline':ParagraphStyle('byline',fontName='MHB',fontSize=9,leading=12,textColor=NAVY,spaceAfter=3),
 'credit':ParagraphStyle('credit',fontName='MHI',fontSize=8.5,leading=11.5,textColor=MUTED,spaceAfter=9),
 'keyhead':ParagraphStyle('keyhead',fontName='MHB',fontSize=10,leading=13,textColor=TEAL,spaceAfter=5),
 'key':ParagraphStyle('key',fontName='MH',fontSize=9,leading=11.5,textColor=NAVY,leftIndent=11,bulletIndent=0,bulletFontName='MH',bulletFontSize=8,spaceAfter=3),
 'body':ParagraphStyle('body',fontName='MH',fontSize=10,leading=13,textColor=NAVY,spaceAfter=8),
 'notes':ParagraphStyle('notes',fontName='MH',fontSize=7.2,leading=10,textColor=MUTED,spaceBefore=4,spaceAfter=3),
 'cell':ParagraphStyle('cell',fontName='MH',fontSize=8.5,leading=11,textColor=NAVY),
 'head':ParagraphStyle('head',fontName='MHB',fontSize=8.1,leading=10.5,textColor=colors.white),
 'ack':ParagraphStyle('ack',fontName='MH',fontSize=8.5,leading=11.5,textColor=MUTED,spaceBefore=7),
}
def para(t,style='body'):return Paragraph(t,S[style])
def summary():
 items=[para('Key findings from the Lean models','keyhead')]+[Paragraph(escape(t),S['key'],bulletText='•') for t in D['key_findings']]
 box=Table([[items]],colWidths=[WIDTH]);box.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,-1),colors.HexColor('#EFF6F5')),('BOX',(0,0),(-1,-1),0.4,colors.HexColor('#CFE1DF')),('LEFTPADDING',(0,0),(-1,-1),9),('RIGHTPADDING',(0,0),(-1,-1),9),('TOPPADDING',(0,0),(-1,-1),7),('BOTTOMPADDING',(0,0),(-1,-1),5)]));return box

def blueprint(b):
 rows=[b['headers']]+b['rows'];t=Table([[para(escape(v),'head' if i==0 else 'cell') for v in row] for i,row in enumerate(rows)],colWidths=[90,215,WIDTH-305],repeatRows=1,hAlign='LEFT')
 t.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),NAVY),('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.HexColor('#EFF5F6'),colors.white]),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),6),('RIGHTPADDING',(0,0),(-1,-1),6),('TOPPADDING',(0,0),(-1,-1),5),('BOTTOMPADDING',(0,0),(-1,-1),5)]));return t

story=[]
md=[f"# {D['title']}",D['subtitle'],f"**{D['author']} | {D['date']}**",'*'+D['ai_credit']+'*','## Key findings from the Lean models','\n'.join('- '+x for x in D['key_findings'])]
plain=[D['title'],D['subtitle'],D['author']+' | '+D['date'],D['ai_credit'],'Key findings from the Lean models']+['- '+x for x in D['key_findings']]
for i,page in enumerate(D['pages'],1):
 if i>1:story.append(PageBreak())
 story.append(para(f'MAGNIFICA HUMANITAS / PUBLIC REPORT {D["version"]} / {i} OF {TOTAL}','kicker'))
 if i==1:
  story.extend([para(escape(D['title']),'title'),para(escape(D['subtitle']),'subtitle'),para(escape(D['author']+' | '+D['date']),'byline'),para(escape(D['ai_credit']),'credit'),summary(),Spacer(1,12),para('1. '+escape(page['title']),'section')])
 else:
  story.extend([para(str(i)+'. '+escape(page['title']),'section'),para(escape(page['deck']),'deck')])
 md.append('## '+page['title']);plain.append(page['title'])
 for p in page['paragraphs']:
  story.append(para('<b>'+escape(p['label'])+'.</b> '+escape(p['text'])))
  md.append('**'+p['label']+'.** '+p['text']);plain.append(p['label']+'. '+p['text'])
  b=page.get('table')
  if b and b['after_paragraph']==p['id']:
   story.extend([blueprint(b),Spacer(1,9)])
   rows=[b['headers'],['---']*len(b['headers'])]+b['rows'];md.append('\n'.join(' | '.join(r) for r in rows));plain.extend(' | '.join(r) for r in [b['headers']]+b['rows'])
 story.extend([Spacer(1,3),para(('<a name="evidence"/>' if i==TOTAL else '')+escape(page['notes']),'notes')]);md.append('*'+page['notes']+'*');md.append('[Official English source PDF]('+D['source_url']+')');plain.append(page['notes'])
 if i==TOTAL:
  a=D['acknowledgment'];story.append(para('<b>'+escape(a['heading'])+'.</b> '+escape(a['text']),'ack'));md.extend(['## '+a['heading'],a['text']]);plain.extend([a['heading'],a['text']])

def footer(c,doc):
 c.saveState();c.setStrokeColor(colors.HexColor('#D7E1E6'));c.line(45,41,550.276,41)
 c.setFillColor(MUTED);c.setFont('MH',7);c.drawString(45,27,f'MAGNIFICA HUMANITAS | Public report {D["version"]}')
 c.setFillColor(TEAL);c.drawString(350,27,'Source PDF');c.drawString(425,27,'Evidence')
 c.linkURL(D['source_url'],(350,24,395,36),relative=0);c.linkRect('Evidence and companion source package','evidence',(425,24,465,36),relative=0,thickness=0)
 c.setFillColor(MUTED);c.drawRightString(550.276,27,f'{doc.page} / {TOTAL}');c.restoreState()
class DeterministicCanvas(pdfcanvas.Canvas):
 def __init__(self,*a,**k):k['invariant']=1;super().__init__(*a,**k)
target=OUT/'MagnificaHumanitas_Plain_Language_Progress_Report.pdf'
doc=SimpleDocTemplate(str(target),pagesize=(595.276,841.89),leftMargin=45,rightMargin=45,topMargin=35,bottomMargin=54,title=D['title'],author=D['author'],subject=D['subtitle'])
doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=DeterministicCanvas)
(ROOT/'docs/PUBLIC_REPORT.md').write_text('\n\n'.join(md)+'\n');(OUT/'report_text.txt').write_text('\n\n'.join(plain)+'\n');print(target)
