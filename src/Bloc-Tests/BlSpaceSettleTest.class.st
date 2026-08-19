Class {
	#name : #BlSpaceSettleTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceSettleTest >> testDeferAndSettleEnsuresEquilibrium [

	| aSpace element |
	aSpace := self newTestingSpace.
	element := BlElement new.
	aSpace deferAndSettle: [
		aSpace root addChild: element.
		element size: 120 @ 80 ].
	self assert: aSpace isSettled.
	self assert: element extent equals: 120 @ 80
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferAndSettleFromUIProcessIsReentrant [

	| aSpace nestedExecuted |
	aSpace := self newTestingSpace.
	nestedExecuted := false.
	aSpace deferAndSettle: [
		aSpace deferAndSettle: [ nestedExecuted := true ] ].
	self assert: nestedExecuted.
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferAndSettlePreservesSequentialOrdering [

	| aSpace items |
	aSpace := self newTestingSpace.
	items := OrderedCollection new.
	aSpace defer: [ items add: 1 ].
	aSpace defer: [ items add: 2 ].
	aSpace defer: [ items add: 3 ].
	aSpace settle.
	self assert: items asArray equals: #(1 2 3)
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferOnOpenedSpaceRunsOnUIProcess [

	| aSpace isUI |
	aSpace := self newTestingSpace.
	isUI := false.
	aSpace defer: [ isUI := aSpace host isUIProcess ].
	aSpace settle.
	self assert: isUI
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferOnUnopenedSpaceExecutesImmediately [

	| aSpace executed |
	aSpace := BlSpace new.
	executed := false.
	aSpace defer: [ executed := true ].
	self assert: executed.
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWhenEmpty [

	| aSpace |
	aSpace := self newTestingSpace.
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithInfiniteAnimation [

	| aSpace element anim |
	aSpace := self newTestingSpace.
	element := BlElement new.
	aSpace deferAndSettle: [ aSpace root addChild: element ].
	anim := BlNumberTransition new
		from: 0;
		to: 100;
		beInfinite;
		yourself.
	element addAnimation: anim.
	aSpace settle.
	self assert: aSpace isSettled.
	self assert: anim isInfinite.
	self deny: anim isPending
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithPendingDeferredActionInUniverse [

	| aSpace executed |
	aSpace := self newTestingSpace.
	executed := false.
	aSpace universe defer: [ executed := true ].
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: aSpace isSettled.
	self assert: executed
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithPendingLayout [

	| aSpace element |
	aSpace := self newTestingSpace.
	element := BlElement new.
	aSpace deferAndSettle: [ aSpace root addChild: element ].

	element requestLayout.
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithPendingTask [

	| aSpace task executed |
	aSpace := self newTestingSpace.
	executed := false.
	task := BlTaskAction new action: [ executed := true ].
	aSpace taskQueue enqueue: task.
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: aSpace isSettled.
	self assert: executed
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithRepeatedTask [

	| aSpace count task |
	aSpace := self newTestingSpace.
	count := 0.
	task := BlRepeatedTaskAction new
		delay: 500 milliSeconds;
		action: [ count := count + 1 ];
		yourself.
	aSpace taskQueue enqueue: task.
	self assert: task isPending.
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: aSpace isSettled.
	self deny: task isPending.
	self assert: count equals: 1
]

{ #category : #tests }
BlSpaceSettleTest >> testSettleForDurationWithContinuousSelfReschedulingTask [

	| aSpace running task |
	aSpace := self newTestingSpace.
	running := true.
	task := BlTaskAction new action: [
		running ifTrue: [ aSpace taskQueue enqueue: task ] ].
	aSpace taskQueue enqueue: task.
	aSpace settleForDuration: 60 milliSeconds.
	running := false.
	aSpace settle.
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testWaitUntilTrueAwakenedOnPulse [

	| aSpace pulses flag |
	aSpace := self newTestingSpace.
	pulses := 0.
	flag := false.
	aSpace defer: [
		pulses := pulses + 1.
		flag := true ].
	aSpace waitUntilTrue: [ flag ].
	self assert: flag.
	self assert: pulses equals: 1
]

{ #category : #tests }
BlSpaceSettleTest >> testWaitUntilTrueConditionMetImmediately [

	| aSpace |
	aSpace := self newTestingSpace.
	aSpace waitUntilTrue: [ true ].
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testWaitUntilTrueForDurationTimesOut [

	| aSpace completed |
	aSpace := self newTestingSpace.
	completed := false.
	aSpace waitUntilTrue: [ false ] forDuration: 50 milliSeconds.
	completed := true.
	self assert: completed
]
