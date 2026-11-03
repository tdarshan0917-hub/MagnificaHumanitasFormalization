"""Shared vector correction-route diagram; no generated or inferred case facts."""
import io
from pathlib import Path
from reportlab.graphics.shapes import Drawing, Rect, String, Line, Polygon
from reportlab.graphics import renderSVG, renderPDF
from reportlab.lib import colors

NAVY=colors.HexColor('#152D45');TEAL=colors.HexColor('#147D80')
RED=colors.HexColor('#AC3D3D');MUTED=colors.HexColor('#526375')

def correction_diagram(width=505.276):
    scale=width/505.276
    d=Drawing(505.276,190)
    d.add(Rect(0,166,505.276,23,rx=3,fillColor=colors.HexColor('#EAF3F2'),strokeColor=None))
    d.add(String(252.638,174,'A named person remains responsible for the case throughout',fontName='MHB',fontSize=9,textAnchor='middle',fillColor=TEAL))
    boxes=[(0,102,['1  Existing denial','in the case record']),
           (176.5,102,['2  Appeal accepted','and brought to review']),
           (353,102,['3  Review finds the','denial should change']),
           (353,36,['4  Finding reaches','the office that can act']),
           (176.5,36,['5  Authorized office','applies the correction']),
           (0,36,['6  Check the result','Recommended final check'])]
    for x,y,lines in boxes:
        d.add(Rect(x,y,152,43,rx=4,fillColor=colors.HexColor('#F1F5F7'),strokeColor=colors.HexColor('#C9D6DF'),strokeWidth=.7))
        for j,s in enumerate(lines):
            d.add(String(x+76,y+26-j*13,s,fontName='MHB' if j==0 else 'MH',fontSize=8.8,textAnchor='middle',fillColor=NAVY))
    def arrow(x1,y1,x2,y2):
        d.add(Line(x1,y1,x2,y2,strokeColor=TEAL,strokeWidth=1.5))
        if x2>x1:pts=[x2,y2,x2-5,y2+3,x2-5,y2-3]
        elif x2<x1:pts=[x2,y2,x2+5,y2+3,x2+5,y2-3]
        else:pts=[x2,y2,x2-3,y2+5,x2+3,y2+5]
        d.add(Polygon(pts,fillColor=TEAL,strokeColor=TEAL))
    arrow(153,123.5,174.5,123.5);arrow(329.5,123.5,351,123.5)
    arrow(429,100,429,81);arrow(351,57.5,330,57.5);arrow(174.5,57.5,153,57.5)
    # Mark three modeled failure locations with a red cross and nearby label.
    for x,y in [(163,123.5),(429,90),(320,42)]:
        d.add(Line(x-3,y-3,x+3,y+3,strokeColor=RED,strokeWidth=1.8))
        d.add(Line(x-3,y+3,x+3,y-3,strokeColor=RED,strokeWidth=1.8))
    d.add(String(12,13,'Red gaps: appeal not accepted; finding not delivered; office does not apply the correction.',fontName='MH',fontSize=8.1,fillColor=RED))
    d.add(String(12,1,'In this example, any of these gaps leaves the stored denial unchanged.',fontName='MH',fontSize=8.1,fillColor=MUTED))
    if scale!=1:
        d.scale(scale,scale);d.width=width;d.height=190*scale
    return d

def export_diagram(root):
    import fitz
    target=Path(root)/'output/figures';target.mkdir(parents=True,exist_ok=True)
    drawing=correction_diagram()
    svg_path=target/'decision_to_correction.svg'
    renderSVG.drawToFile(drawing,str(svg_path))
    svg=svg_path.read_text().replace('<title>...</title>','<title>From a benefits denial to an applied correction</title>').replace('<desc>...</desc>','<desc>Six steps in the reference example, with three failure points. A named person remains responsible throughout. The final inspection is a recommended check of the returned result.</desc>')
    svg=svg.replace('font-family: MHB;', 'font-family: DejaVu Sans, Arial, sans-serif; font-weight: bold;').replace('font-family: MH;', 'font-family: DejaVu Sans, Arial, sans-serif;')
    svg_path.write_text(svg)
    data=renderPDF.drawToString(drawing)
    doc=fitz.open(stream=data,filetype='pdf')
    doc[0].get_pixmap(matrix=fitz.Matrix(3,3),alpha=False).save(target/'decision_to_correction.png')
