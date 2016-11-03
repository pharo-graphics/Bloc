*Bloc-Athens
applyBeforeOnAthensCanvas: anAthensCanvas for: anElement
	| aPath aPathTx scaleFactor alphaOffset h w|

	aPath := anElement asAthensPathOn: anAthensCanvas.
	aPathTx := anAthensCanvas pathTransform.
	alphaOffset := (self color alpha) / (self width).
	w := anElement geomBounds width .
	h := anElement geomBounds height.
	anElement geomBounds isZero 
		ifTrue:[scaleFactor := 1@1]
		ifFalse:[scaleFactor := (((w + 1) / (w max:1)) @ ((h + 1) / (h max:1)))].
	aPathTx restoreAfter: [ 
		
		aPathTx translateX:(self offset x) Y:(self offset y).
		anAthensCanvas
					setPaint: (self color);
					drawShape: aPath;
					setPaint: ((self color asStrokePaintOn: anAthensCanvas) width:0.5);
					drawShape: aPath.
					
		1 to:(self width) do: [ :i | 
			|newColor|
				aPathTx translateX:0.5 negated Y:0.5 negated.
				aPathTx scaleBy: scaleFactor.
				newColor := self color alpha:(self color alpha - (alphaOffset*i)).
				anAthensCanvas
					setPaint: ((newColor asStrokePaintOn: anAthensCanvas) width:0.5);
					drawShape: aPath.
					 ] ]