drawing
drawPathOn: aCanvas
	| pt |
	pt := aCanvas pathTransform.
	
	pt   restoreAfter: [ 
			border applyTransformOn: pt extent: self extent.
			aCanvas
				setPaint: background fill;
				drawShape: (pathCache geomPathOn: aCanvas);
				setPaint: border stroke;
				drawShape: (pathCache geomPathOn: aCanvas) ].
	