Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Layout' }
BlElementGeometry >> anchorBoundsOf: anElement inParent: aParentElement [

	^ anElement measuredBounds inParent: aParentElement
]

{ #category : #'*Bloc-Layout' }
BlElementGeometry >> anchorLayoutBoundsOfElement: anElement [

	^ anElement measuredBounds
]
