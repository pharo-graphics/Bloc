Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawOpenPathWith: [ :cairoContext |
		cairoContext
			moveTo: from;
			lineTo: to ]

]

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry"

	^ aPoint
		onLineFrom: from
		to: to
		within: aBlElement border width / 2
]
