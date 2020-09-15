Class {
	#name : #BlInfiniteLinearLayoutExampleDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'constraintsBlock',
		'itemBlock',
		'colors'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteLinearLayoutExampleDataSource >> colors: aCollection [
	colors := aCollection.
	self notifyChanged
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleDataSource >> constraintsDo: aBlock [
	constraintsBlock := aBlock.
	self notifyChanged
]

{ #category : #initialization }
BlInfiniteLinearLayoutExampleDataSource >> initialize [
	super initialize.
	
	constraintsBlock := [ :c |
		c horizontal exact: 100.
		c vertical exact: 50 ].
	
	itemBlock := [ :anElement | ].
	
	colors := Color registeredColorNames collect: [ :aColorName | Color named: aColorName ]
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleDataSource >> itemCount [
	^ colors size
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleDataSource >> itemDo: aBlock [
	itemBlock := aBlock.
	self notifyChanged
]

{ #category : #'instance creation' }
BlInfiniteLinearLayoutExampleDataSource >> onBindHolder: anElementHolder at: aPosition [
	anElementHolder
		color: (colors at: aPosition);
		constraintsDo: constraintsBlock;
		itemDo: itemBlock
]

{ #category : #'instance creation' }
BlInfiniteLinearLayoutExampleDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteLinearLayoutExampleHolder new
	
]
