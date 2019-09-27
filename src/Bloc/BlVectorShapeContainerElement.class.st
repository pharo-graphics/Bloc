Class {
	#name : #BlVectorShapeContainerElement,
	#superclass : #BlElement,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'as yet unclassified' }
BlVectorShapeContainerElement >> addChild: anElement shape: aShape [
	anElement userData at: #shape put: aShape.
	self addChild: anElement
]

{ #category : #'as yet unclassified' }
BlVectorShapeContainerElement >> elementForShape: aShape ifAbsent: anAbsentBlock [
	^ self children
		detect: [ :eachChild | eachChild userData at: #shape ifPresent: [ :eachShape | eachShape == aShape ] ]
		ifNone: anAbsentBlock
]

{ #category : #'as yet unclassified' }
BlVectorShapeContainerElement >> elementForShape: aShape ifAbsentAdd: anAbsentBlock [
	^ self elementForShape: aShape ifAbsent: [
		| anElement |
		
		anElement := anAbsentBlock cull: aShape.
		self addChild: anElement shape: aShape.
		anElement ]
]
