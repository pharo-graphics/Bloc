Extension { #name : #BlPolylineGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlPolylineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawOpenPathWith: [ :cairoContext |
		self vertices do: [ :each | cairoContext lineTo: each ] ]

]

{ #category : #'*Bloc-Alexandrie' }
BlPolylineGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	self flag: #todo. "This is wrong"
	^ BAOffscreen instance
		  is: aPoint
		  inFillOfVertices: self vertices
]
