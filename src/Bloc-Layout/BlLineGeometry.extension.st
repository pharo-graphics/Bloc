Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Layout' }
BlLineGeometry >> anchorLayoutBoundsOfElement: anElement [
	
	^ self geometryBounds: BlBounds new
]
