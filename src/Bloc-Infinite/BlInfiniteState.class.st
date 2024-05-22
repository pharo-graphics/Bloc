Class {
	#name : #BlInfiniteState,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'layoutStep',
		'itemCount',
		'deletedInvisibleItemCountSincePreviousLayout',
		'focusedItemPosition',
		'focusedItemId',
		'focusedSubChild'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #asserting }
BlInfiniteState >> assertLayoutStep: aStep [
	"Make sure that current layout step is aStep"

	| m |
	m := 'Wrong layout state! It should be: ' , aStep asString
	     , ' but it is ' , layoutStep value asString.

	Bloc debugModeEnabled ifFalse: [ 
		(layoutStep has: aStep) ifFalse: [ m traceCr ].
		^ self ].
	self assert: [ layoutStep has: aStep ] description: [ m ]
]

{ #category : #asserting }
BlInfiniteState >> assertLayoutStep: aStep or: anotherStep [
	"Make sure that current layout step is aStep"

	((layoutStep has: aStep) or: [ layoutStep has: anotherStep ])
		ifFalse: [ self error: 'Wrong layout state! It should be: ', aStep asString, ' or ', anotherStep asString, ' but it is ', layoutStep value asString ]
]

{ #category : #'accessing - step' }
BlInfiniteState >> beStepFinal [

	layoutStep clear.
	layoutStep addFinal
]

{ #category : #'accessing - step' }
BlInfiniteState >> beStepLayout [

	layoutStep clear.
	layoutStep addLayout
]

{ #category : #'accessing - step' }
BlInfiniteState >> beStepStart [

	layoutStep clear.
	layoutStep addStart
]

{ #category : #initialization }
BlInfiniteState >> defaultLayoutStep [

	^ BlInfiniteLayoutStepFlags new
		addStart;
		yourself
]

{ #category : #accessing }
BlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout [
	^ deletedInvisibleItemCountSincePreviousLayout
]

{ #category : #accessing }
BlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout: anInteger [

	deletedInvisibleItemCountSincePreviousLayout := anInteger
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedItemId [
	^ focusedItemId
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedItemId: anObject [
	focusedItemId := anObject
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedItemPosition [
	^ focusedItemPosition
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedItemPosition: anInteger [
	focusedItemPosition := anInteger
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedSubChild [
	^ focusedSubChild
]

{ #category : #'accessing - focus' }
BlInfiniteState >> focusedSubChild: anObject [
	focusedSubChild := anObject
]

{ #category : #initialization }
BlInfiniteState >> initialize [
	super initialize.
	

	layoutStep := self defaultLayoutStep.
	itemCount := 0.
	deletedInvisibleItemCountSincePreviousLayout := 0.
	focusedItemPosition := NoPosition.
	focusedItemId := NoId.
	focusedSubChild := nil
]

{ #category : #'testing - step' }
BlInfiniteState >> isStartStep [

	^ layoutStep hasStart
]

{ #category : #accessing }
BlInfiniteState >> itemCount [

	^ itemCount
]

{ #category : #accessing }
BlInfiniteState >> itemCount: aNumber [
	itemCount := aNumber
]

{ #category : #invalidate }
BlInfiniteState >> reset [

	itemCount := 0
]
