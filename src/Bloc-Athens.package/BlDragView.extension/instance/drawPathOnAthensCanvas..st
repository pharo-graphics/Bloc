*Bloc-Athens-drawing
drawPathOnAthensCanvas: aCanvas
	| pt |
	pt := aCanvas pathTransform.
	
	pt   restoreAfter: [ 
			border applyTransformOnAthensTransform: pt extent: self extent.
			aCanvas
				setPaint: background fill;
				drawShape: (pathCache geomPathOnAthensCanvas: aCanvas);
				setPaint: target;
				drawShape: (pathCache geomPathOnAthensCanvas: aCanvas);
				setPaint: border stroke;
				drawShape: (pathCache geomPathOnAthensCanvas: aCanvas) ].
	