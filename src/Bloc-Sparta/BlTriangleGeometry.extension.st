Extension { #name : #BlTriangleGeometry }

{ #category : #'*Bloc-Sparta' }
BlTriangleGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| aPathBuilder thePoints |

	aPathBuilder := aCanvas path.
	thePoints := self computeVertices.
	
	aPathBuilder moveTo: thePoints first.
	thePoints allButFirstDo: [ :eachPoint |
		aPathBuilder lineTo: eachPoint ].
	aPathBuilder close.
	
	^ aPathBuilder build
]
