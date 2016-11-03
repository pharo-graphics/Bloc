drawing
drawPathOn: aCanvas
	| pt |
	pt := aCanvas pathTransform.
	
	pt   restoreAfter: [ 
			
			aCanvas
				setPaint: background fill;
				drawShape: (self pathOn: aCanvas);
				setPaint: border stroke;
				drawShape: (self pathOn: aCanvas) ].
	