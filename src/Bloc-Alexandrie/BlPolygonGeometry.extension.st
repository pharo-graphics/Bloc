Extension { #name : #BlPolygonGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext | 
		self vertices do: [ :each | cairoContext lineTo: each ].
		cairoContext closePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlPolygonGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by a this geometry."

	^ BAPolygonHitTester doPolygonBy: self vertices include: aPoint
]
