Class {
	#name : 'BlLayoutGraphEdgesIterator',
	#superclass : 'BlLayoutGraphIterator',
	#package : 'Bloc',
	#tag : 'Layouts-Model'
}

{ #category : 'api - enumeration' }
BlLayoutGraphEdgesIterator >> do: aBlock [
	"Evaluate a given block with all iterator items"
	
	^ self subclassResponsibility
]

{ #category : 'api - iterator' }
BlLayoutGraphEdgesIterator >> nodes [
	^ BlLayoutGraphConnectedNodes on: self layoutNode from: self
]
