Extension { #name : #BlPolylineGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlPolylineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		"Cairo treats first lineTo: as a moveTo:"
		vertices do: [ :each | cairoContext lineTo: each ] ]

]

{ #category : #'*Bloc-Alexandrie' }
BlPolylineGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	
	Based on RSPolyline>>#basicIncludesPoint:"

	vertices overlappingPairsDo: [ :a :b | 
		(aPoint onLineFrom: a to: b within: aBlElement border width / 2) 
			ifTrue: [ ^ true ] ].
	^ false
]
