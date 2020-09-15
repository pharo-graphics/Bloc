Class {
	#name : #BlInfiniteLinearLayoutExampleElement,
	#superclass : #BlInfiniteElement,
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteLinearLayoutExampleElement >> defaultDataSource [
	^ BlInfiniteLinearLayoutExampleDataSource new
]

{ #category : #initialization }
BlInfiniteLinearLayoutExampleElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleElement >> itemConstraintsDo: aBlock [
	self dataSource constraintsDo: aBlock
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleElement >> itemDo: aBlock [
	self dataSource itemDo: aBlock
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleElement >> items: aNumberOfColors [
	self dataSource colors: (Color wheel: aNumberOfColors)
]
