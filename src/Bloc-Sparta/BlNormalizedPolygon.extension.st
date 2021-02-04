Extension { #name : #BlNormalizedPolygon }

{ #category : #'*Bloc-Sparta' }
BlNormalizedPolygon >> buildPathOnSpartaCanvas: aCanvas [
	| theScaledVertices aPathBuilder |
	
	aPathBuilder := aCanvas path. 
	
	theScaledVertices := self vertices collect: [ :eachVertex | (self extent * eachVertex) asFloatPoint ].
	theScaledVertices size <= 1
		ifTrue: [ ^ aPathBuilder build ].
	
	aPathBuilder moveTo: theScaledVertices first.
	theScaledVertices allButFirstDo: [ :eachVertex | aPathBuilder lineTo: eachVertex ].
	aPathBuilder close.

	^ aPathBuilder build
]
