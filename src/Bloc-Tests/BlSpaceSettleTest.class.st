Class {
	#name : #BlSpaceSettleTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceSettleTest >> testCloseAndSettleClosesWindowSynchronously [

	| aSpace |
	aSpace := self newTestingSpace.
	self assert: aSpace isOpened.
	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferAndSettleEnsuresEquilibrium [

	| aSpace element |
	aSpace := self newTestingSpace.
	element := BlElement new.
	aSpace deferAndSettle: [
		aSpace root addChild: element.
		element extent: 120 @ 80 ].
	self assert: aSpace isSettled.
	self assert: element extent equals: 120 @ 80
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferAndSettleFromPulseProcessRaisesError [

	| aSpace errorRaised |
	aSpace := self newTestingSpace.
	errorRaised := false.
	aSpace defer: [
		[ aSpace deferAndSettle: [ ] ]
			on: Error
			do: [ :err | errorRaised := true ] ].
	aSpace settle.
	self assert: errorRaised
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
BlSpaceSettleTest >> testDeferErrorDoesNotPreventSettle [

	| aSpace errorCaught stepExecuted |
	aSpace := self newTestingSpace.
	errorCaught := false.
	stepExecuted := false.
	aSpace defer: [
		[ Error signal: 'Expected defer error' ]
			on: Error
			do: [ :e | errorCaught := true ] ].
	aSpace defer: [ stepExecuted := true ].
	aSpace settle.
	self assert: errorCaught.
	self assert: stepExecuted.
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferOnOpenedSpaceRunsOnPulseProcess [

	| aSpace isPulse |
	aSpace := self newTestingSpace.
	isPulse := false.
	aSpace defer: [ isPulse := aSpace host isPulseProcessActive ].
	self deny: isPulse.
	aSpace settle.
	self assert: isPulse
]

{ #category : #tests }
BlSpaceSettleTest >> testDeferOnUnopenedSpaceExecutesOnFirstPulse [

	| aSpace executed |
	aSpace := BlSpace new.
	executed := false.
	aSpace defer: [ executed := true ].
	self deny: executed.
	self deny: aSpace isOpened.

	aSpace show.
	aSpace settle.
	self assert: executed.
	self assert: aSpace isOpened.
	aSpace close.
	aSpace settle
]

{ #category : #tests }
BlSpaceSettleTest >> testHostCloseSpacesClosesAllAndStopsHost [

	| space1 space2 |
	space1 := self newTestingSpace.
	space2 := self newTestingSpace.
	self assert: (host spaces includes: space1).
	self assert: (host spaces includes: space2).
	self assert: host isRunning.

	host closeSpaces.
	host settle.
	self deny: space1 isOpened.
	self deny: space2 isOpened.
	self assert: host spaces isEmpty.
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceSettleTest >> testHostSettleWhenStoppedCompletesImmediately [

	self deny: host isRunning.
	self assert: host isSettled.

	host settle.
	self deny: host isRunning.
	self assert: host isSettled
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
	anim :=
		BlNumberTransition new
			from: 0;
			to: 100;
			beInfinite;
			yourself.
	element addAnimation: anim.
	self assert: aSpace isSettled. "Infinite animations don't make it not settled"

	aSpace settle.
	self assert: aSpace isSettled.
	self assert: anim isInfinite.
	self assert: anim isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithPendingDeferredAction [

	| aSpace executed |
	aSpace := self newTestingSpace.
	executed := false.
	aSpace defer: [ executed := true ].
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

	aSpace defer: [ aSpace root addChild: element ].
	self assert: element width equals: 0. "Still default width didn't apply"
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: element width equals: 50. "Default width was applied"
	self assert: aSpace isSettled.

	aSpace defer: [ element width: 100 ].
	self assert: element width equals: 50. "New width still not applied"
	self deny: aSpace isSettled.

	aSpace settle.
	self assert: element width equals: 100. "New width was applied"
	self assert: aSpace isSettled
]

{ #category : #tests }
BlSpaceSettleTest >> testIsSettledWithPendingTask [

	| aSpace task executed |
	aSpace := self newTestingSpace.
	executed := false.
	task := BlTaskAction with: [ executed := true ].
	aSpace enqueueTask: task.
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
	task :=
		BlRepeatedTaskAction new
			delay: 500 milliSeconds;
			action: [ count := count + 1 ];
			yourself.
	aSpace enqueueTask: task.

	"Not settled, only first time"
	self deny: aSpace isSettled. 
	self deny: task isSettled.
	self assert: count equals: 0.

	aSpace settle.
	self assert: aSpace isSettled.
	self assert: task isSettled.
	self assert: count equals: 1
]

{ #category : #tests }
BlSpaceSettleTest >> testSettleForDurationWithContinuousSelfReschedulingTask [

	| aSpace running enqueueBlock |
	aSpace := self newTestingSpace.
	running := true.
	enqueueBlock := [
		running ifTrue: [
			aSpace enqueueTask: (BlTaskAction with: enqueueBlock) ] ].

	enqueueBlock value.

	self deny: (aSpace settleForDuration: 100 milliSeconds).
	running := false.
	self assert: (aSpace settleForDuration: 100 milliSeconds)
]

{ #category : #tests }
BlSpaceSettleTest >> testSettleFromPulseProcessRaisesError [

	| aSpace errorRaised |
	aSpace := self newTestingSpace.
	errorRaised := false.
	aSpace defer: [
		[ aSpace settle ]
			on: Error
			do: [ :err | errorRaised := true ] ].
	aSpace settle.
	self assert: errorRaised
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

{ #category : #tests }
BlSpaceSettleTest >> testWaitUntilTrueFromPulseProcessRaisesError [

	| aSpace errorRaised |
	aSpace := self newTestingSpace.
	errorRaised := false.
	aSpace defer: [
		[ aSpace waitUntilTrue: [ true ] ]
			on: Error
			do: [ :err | errorRaised := true ] ].
	aSpace settle.
	self assert: errorRaised
]
