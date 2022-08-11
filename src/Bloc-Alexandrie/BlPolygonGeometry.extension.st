Extension { #name : #BlPolygonGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: true "probably"
		hasCaps: false
		block: [ :cairoContext | 
			self vertices do: [ :each | cairoContext lineTo: each ].
			cairoContext primClosePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ AeOffscreen instance
		  is: aPoint
		  inFillOfVertices: self vertices
]
