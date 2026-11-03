"""Build the technical paper and editable Markdown from one manuscript."""
import json
import re
from pathlib import Path
from xml.sax.saxutils import escape
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, Preformatted
from reportlab.pdfgen import canvas

ROOT = Path(__file__).resolve().parents[1]
PAPER = json.loads((ROOT / 'paper/manuscript.json').read_text())
OUT = ROOT / 'output/pdf'
OUT.mkdir(parents=True, exist_ok=True)
FONT = Path('/usr/share/fonts/truetype/dejavu')
for name, filename in [('MH','DejaVuSans.ttf'),('MHB','DejaVuSans-Bold.ttf'),('MHM','DejaVuSansMono.ttf')]:
    pdfmetrics.registerFont(TTFont(name, str(FONT / filename)))
pdfmetrics.registerFontFamily('MH', normal='MH', bold='MHB', italic='MH', boldItalic='MHB')
NAVY, TEAL, MUTED = [colors.HexColor(x) for x in ['#152D45','#147D80','#526375']]
WIDTH = 504
STYLES = {
 'title':ParagraphStyle('title',fontName='MHB',fontSize=23,leading=28,textColor=NAVY,spaceAfter=12),
 'page':ParagraphStyle('page',fontName='MHB',fontSize=17,leading=22,textColor=NAVY,spaceAfter=14),
 'p':ParagraphStyle('p',fontName='MH',fontSize=10.1,leading=14.1,textColor=NAVY,spaceAfter=9),
 'last':ParagraphStyle('last',fontName='MH',fontSize=9.5,leading=13,textColor=NAVY,spaceAfter=7),
 'h':ParagraphStyle('h',fontName='MHB',fontSize=11,leading=15,textColor=TEAL,spaceBefore=6,spaceAfter=5,keepWithNext=True),
 'formula':ParagraphStyle('formula',fontName='MH',fontSize=9.3,leading=13.5,textColor=NAVY,spaceAfter=5),
 'lean':ParagraphStyle('lean',fontName='MHM',fontSize=7.5,leading=10.5,textColor=MUTED,spaceAfter=9,splitLongWords=True),
 'cell':ParagraphStyle('cell',fontName='MH',fontSize=8.5,leading=11.5,textColor=NAVY),
 'head':ParagraphStyle('head',fontName='MHB',fontSize=8.4,leading=11.5,textColor=colors.white),
 'code':ParagraphStyle('code',fontName='MHM',fontSize=8,leading=11,textColor=NAVY,spaceAfter=9),
 'small':ParagraphStyle('small',fontName='MH',fontSize=8,leading=12,textColor=MUTED,spaceAfter=10),
 'ref':ParagraphStyle('ref',fontName='MH',fontSize=9,leading=12,textColor=NAVY,spaceAfter=5),
}
def paragraph(text, key='p'):
    return Paragraph(escape(text).replace('\n','<br/>'),STYLES[key])
def panel(items, background):
    t=Table([[items]],colWidths=[WIDTH])
    t.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,-1),background),('BOX',(0,0),(-1,-1),0.4,colors.HexColor('#D7E5E7')),('LEFTPADDING',(0,0),(-1,-1),9),('RIGHTPADDING',(0,0),(-1,-1),9),('TOPPADDING',(0,0),(-1,-1),8),('BOTTOMPADDING',(0,0),(-1,-1),6)]))
    return t
story=[]
md=[f"# {PAPER['title']}",PAPER['subtitle'],f"{PAPER['author']} · {PAPER['date']} · Version {PAPER['version']}",f"Formal source revision: `{PAPER['formal_commit']}`",'Release DOI: '+PAPER['doi_url']]
for index,page in enumerate(PAPER['pages']):
    if index: story.append(PageBreak())
    if not index:
        story.append(paragraph(f'MAGNIFICA HUMANITAS / RELEASE {PAPER["release"]} / TECHNICAL PAPER {PAPER["version"]}', 'small'))
        story.append(paragraph(page['title'],'title'))
        story.append(Paragraph(escape(PAPER['author']+' | '+PAPER['date'])+' | DOI: <link href="'+PAPER['doi_url']+'">'+escape(PAPER['doi'])+'</link>',STYLES['small']))
    else:
        story.append(paragraph(page['title'],'page'))
        md.append('## '+page['title'])
    for block in page['blocks']:
        typ=block['type']
        if typ in ['p','h','lean']:
            txt=block['text']
            story.append(paragraph(('Lean evidence: '+txt) if typ=='lean' else txt,('ref' if index==len(PAPER['pages'])-1 and typ=='p' and txt.startswith('[') else ('last' if index==len(PAPER['pages'])-1 and typ=='p' else typ))))
            md.append(('### '+txt) if typ=='h' else (('Lean evidence: `'+txt+'`') if typ=='lean' else txt))
        elif typ=='formula':
            story.extend([panel([paragraph(block['text'],'formula')],colors.HexColor('#F0F4F7')),Spacer(1,9)])
            md.append('```text\n'+block['text']+'\n```')
        elif typ=='code':
            story.append(Preformatted(block['text'],STYLES['code']))
            md.append('```\n'+block['text']+'\n```')
        elif typ=='theorem':
            story.extend([panel([paragraph(block['title'],'h'),paragraph(block['text'])],colors.HexColor('#EDF7F5')),Spacer(1,10)])
            md.append('**'+block['title']+'.** '+block['text'])
        elif typ=='table':
            rows=block['rows']; ratios=block['widths']
            t=Table([[paragraph(cell,'head' if i==0 else 'cell') for cell in row] for i,row in enumerate(rows)],colWidths=[WIDTH*x/sum(ratios) for x in ratios],repeatRows=1,hAlign='LEFT')
            t.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),NAVY),('ROWBACKGROUNDS',(0,1),(-1,-1),[colors.HexColor('#F0F5F6'),colors.white]),('VALIGN',(0,0),(-1,-1),'TOP'),('LEFTPADDING',(0,0),(-1,-1),7),('RIGHTPADDING',(0,0),(-1,-1),7),('TOPPADDING',(0,0),(-1,-1),6),('BOTTOMPADDING',(0,0),(-1,-1),6)]))
            story.extend([t,Spacer(1,10)])
            md.append('\n'.join([' | '.join(rows[0]),' | '.join(['---']*len(rows[0]))]+[' | '.join(r) for r in rows[1:]]))
        else: raise ValueError(typ)

def footer(c,doc):
    c.saveState(); c.setStrokeColor(colors.HexColor('#D7E1E6')); c.line(54,44,558,44)
    c.setFillColor(MUTED); c.setFont('MH',7)
    c.drawString(54,30,f'RELEASE {PAPER["release"]} | FROM PRINCIPLES TO WORKING SAFEGUARDS | Technical {PAPER["version"]}')
    c.drawRightString(558,30,str(doc.page)); c.restoreState()
class DeterministicCanvas(canvas.Canvas):
    def __init__(self,*args,**kwargs):
        kwargs['invariant']=1
        super().__init__(*args,**kwargs)
path=OUT/'MagnificaHumanitas_Technical_Paper.pdf'
doc=SimpleDocTemplate(str(path),pagesize=(612,792),leftMargin=54,rightMargin=54,topMargin=44,bottomMargin=60,title=PAPER['title'],author=PAPER['author'],subject=PAPER['subtitle'])
doc.build(story,onFirstPage=footer,onLaterPages=footer,canvasmaker=DeterministicCanvas)
(ROOT/'docs/TECHNICAL_PAPER.md').write_text('\n\n'.join(md)+'\n')
print(path)
