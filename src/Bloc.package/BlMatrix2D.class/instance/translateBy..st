matrix - transformations
translateBy: aBlVector
	"Apply a translation by a given vector"
	| aTranslate3D |
	
	aTranslate3D := aBlVector asTranslate3D.
	
	self
		assert: [ aTranslate3D z isZero ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"
	x := x + aTranslate3D x.
	y := y + aTranslate3D y.