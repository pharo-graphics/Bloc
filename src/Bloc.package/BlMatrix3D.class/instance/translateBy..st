matrix - transformations
translateBy: aBlVector
	| aTranslate3D |
	
	aTranslate3D := aBlVector asTranslate3D.

	self
		postTranslateX: aTranslate3D x
		Y: aTranslate3D y
		Z: aTranslate3D z