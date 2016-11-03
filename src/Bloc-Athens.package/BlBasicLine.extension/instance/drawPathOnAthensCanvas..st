*Bloc-Athens-drawing
drawPathOnAthensCanvas: aCanvas
	| pt |
	pt := aCanvas pathTransform.
	
	pt   restoreAfter: [ 
			
			aCanvas
				setPaint: background fill;
				drawShape: (self pathOnAthensCanvas: aCanvas);
				setPaint: border stroke;
				drawShape: (self pathOnAthensCanvas: aCanvas) ].
	