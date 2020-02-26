Extension { #name : #BlNormalizedPolyline }

{ #category : #'*Bloc-Sparta' }
BlNormalizedPolyline >> buildPathOnSpartaCanvas: aCanvas [
	| theScaledVertices aPathBuilder |
	
	aPathBuilder := aCanvas path. 
	
	theScaledVertices := self vertices collect: [ :eachVertex | self extent * eachVertex ].
	theScaledVertices size <= 1
		ifTrue: [ ^ aPathBuilder build ].
	
	aPathBuilder moveTo: theScaledVertices first.
	theScaledVertices allButFirstDo: [ :eachVertex | aPathBuilder lineTo: eachVertex ].

	^ aPathBuilder build
]
