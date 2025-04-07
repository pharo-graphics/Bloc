Class {
	#name : #BlLayoutGraphEdgesIterator,
	#superclass : #BlLayoutGraphIterator,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - enumeration' }
BlLayoutGraphEdgesIterator >> do: aBlock [
	"Evaluate a given block with all iterator items"
	
	^ self subclassResponsibility
]

{ #category : #'api - iterator' }
BlLayoutGraphEdgesIterator >> nodes [

	^ BlLayoutGraphConnectedNodes on: self layoutNode from: self
]
