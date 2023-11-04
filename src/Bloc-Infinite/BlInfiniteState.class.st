Class {
	#name : 'BlInfiniteState',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'targetPosition',
		'layoutStep',
		'data',
		'itemCount',
		'previousLayoutItemCount',
		'deletedInvisibleItemCountSincePreviousLayout',
		'structureChanged',
		'inPreLayout',
		'trackOldChangeHolders',
		'isMeasuring',
		'focusedItemPosition',
		'focusedItemId',
		'focusedSubChild'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-Core',
	#package : 'Bloc-Infinite',
	#tag : 'Core'
}

{ #category : 'asserting' }
BlInfiniteState >> assertLayoutStep: aStep [
	"Make sure that current layout step is aStep"
	
	self
		assert: [ layoutStep has: aStep ]
		description: [ 'Wrong layout state! It should be: ', aStep asString, ' but it is ', layoutStep value asString ]
]

{ #category : 'asserting' }
BlInfiniteState >> assertLayoutStep: aStep or: anotherStep [
	"Make sure that current layout step is aStep"

	((layoutStep has: aStep) or: [ layoutStep has: anotherStep ])
		ifFalse: [ self error: 'Wrong layout state! It should be: ', aStep asString, ' or ', anotherStep asString, ' but it is ', layoutStep value asString ]
]

{ #category : 'adding/removing' }
BlInfiniteState >> at: aResourceKey [

	^ data at: aResourceKey ifAbsent: nil
]

{ #category : 'adding/removing' }
BlInfiniteState >> at: aResourceKey put: anObject [

	data at: aResourceKey put: anObject
]

{ #category : 'accessing - step' }
BlInfiniteState >> beStepAnimations [

	layoutStep clear.
	layoutStep addAnimations
]

{ #category : 'accessing - step' }
BlInfiniteState >> beStepLayout [

	layoutStep clear.
	layoutStep addLayout
]

{ #category : 'accessing - step' }
BlInfiniteState >> beStepStart [

	layoutStep clear.
	layoutStep addStart
]

{ #category : 'initialization' }
BlInfiniteState >> defaultLayoutStep [

	^ BlInfiniteLayoutStepFlags new
		addStart;
		yourself
]

{ #category : 'accessing' }
BlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout [
	^ deletedInvisibleItemCountSincePreviousLayout
]

{ #category : 'accessing' }
BlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout: anObject [
	deletedInvisibleItemCountSincePreviousLayout := anObject
]

{ #category : 'testing' }
BlInfiniteState >> didStructureChange [
	^ structureChanged
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedItemId [
	^ focusedItemId
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedItemId: anObject [
	focusedItemId := anObject
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedItemPosition [
	^ focusedItemPosition
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedItemPosition: anObject [
	focusedItemPosition := anObject
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedSubChild [
	^ focusedSubChild
]

{ #category : 'accessing - focus' }
BlInfiniteState >> focusedSubChild: anObject [
	focusedSubChild := anObject
]

{ #category : 'testing' }
BlInfiniteState >> hasTargetScrollPosition [
	"Return true if current scroll has a target position, false otherwise"
	<return: #Boolean>

	^ targetPosition ~= NoPosition
]

{ #category : 'initialization' }
BlInfiniteState >> initialize [
	super initialize.
	
	targetPosition := NoPosition.

	layoutStep := self defaultLayoutStep.

	data := Dictionary new.
	
	itemCount := 0.
	previousLayoutItemCount := 0.
	deletedInvisibleItemCountSincePreviousLayout := 0.
	
	structureChanged := false.
	inPreLayout := false.
	trackOldChangeHolders := false.
	isMeasuring := false.
	
	focusedItemPosition := NoPosition.
	focusedItemId := NoId.
	focusedSubChild := nil
]

{ #category : 'testing - step' }
BlInfiniteState >> isLayoutStep [
	^ layoutStep hasLayout
]

{ #category : 'accessing' }
BlInfiniteState >> isMeasuring [
	^ isMeasuring
]

{ #category : 'accessing' }
BlInfiniteState >> isMeasuring: aBoolean [
	isMeasuring := aBoolean
]

{ #category : 'accessing' }
BlInfiniteState >> isPreLayout [
	^ inPreLayout
]

{ #category : 'accessing' }
BlInfiniteState >> isPreLayout: aBoolean [
	inPreLayout := aBoolean
]

{ #category : 'testing - step' }
BlInfiniteState >> isStartStep [
	^ layoutStep hasStart
]

{ #category : 'accessing' }
BlInfiniteState >> itemCount [
	^ inPreLayout
		ifTrue: [ previousLayoutItemCount - deletedInvisibleItemCountSincePreviousLayout ]
		ifFalse: [ itemCount ]
]

{ #category : 'accessing' }
BlInfiniteState >> itemCount: aNumber [
	itemCount := aNumber
]

{ #category : 'accessing' }
BlInfiniteState >> previousLayoutItemCount [
	^ previousLayoutItemCount
]

{ #category : 'accessing' }
BlInfiniteState >> previousLayoutItemCount: anObject [
	previousLayoutItemCount := anObject
]

{ #category : 'adding/removing' }
BlInfiniteState >> remove: aResourceKey [
	data removeKey: aResourceKey ifAbsent: [  ]
]

{ #category : 'invalidate' }
BlInfiniteState >> reset [
	targetPosition := NoPosition.
	data removeAll.
	itemCount := 0.
	structureChanged := false
]

{ #category : 'accessing' }
BlInfiniteState >> structureChanged: aBoolean [

	structureChanged := aBoolean
]

{ #category : 'accessing' }
BlInfiniteState >> targetPosition: aNumber [ 
	targetPosition := aNumber
]

{ #category : 'accessing' }
BlInfiniteState >> targetScrollPosition [
	^ targetPosition
]

{ #category : 'accessing' }
BlInfiniteState >> targetScrollPosition: aPosition [
	targetPosition := aPosition
]

{ #category : 'accessing' }
BlInfiniteState >> trackOldChangeHolders [

	^ trackOldChangeHolders
]

{ #category : 'accessing' }
BlInfiniteState >> trackOldChangeHolders: aBoolean [
	trackOldChangeHolders := aBoolean
]
