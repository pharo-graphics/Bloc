"
I am an abstract class for all Bloc animations. 
See my subclasses for futher documentation and examples: ${class:BlBaseAnimation|show=gtSubclassesFor:|expanded=true}$
"
Class {
	#name : #BlBaseAnimation,
	#superclass : #BlTask,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'loop',
		'delay',
		'time',
		'startTime',
		'progress',
		'elapsedTime',
		'loopCount',
		'isStarted',
		'isRunning',
		'parent',
		'actionHandlers',
		'target',
		'eventDispatcher',
		'loopDoneTime'
	],
	#category : #'Bloc-Animation-Basic'
}

{ #category : #'action  handling' }
BlBaseAnimation >> addOnFinishedHandler: anActionHandler [
	actionHandlers add: anActionHandler
]

{ #category : #accessing }
BlBaseAnimation >> animationManager [
	self 
		deprecated: 'Use BlElement>>#addAnimation:'
		on: 	'2 April 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ nil
]

{ #category : #'private - testing' }
BlBaseAnimation >> atLeastOneLoopDone [
	<return: #Boolean>
	
	^ loopDoneTime isNotNil
]

{ #category : #'api - configuration' }
BlBaseAnimation >> beInfinite [
	self loops: Float infinity
]

{ #category : #'private - testing' }
BlBaseAnimation >> canHaveNextLoop [
	<return: #Boolean>

	self
		assert: [ self isRunning ]
		description: [ 'I must be running' ].

	^ self isInfinite or: [ loopCount < loop ]
]

{ #category : #'api - time' }
BlBaseAnimation >> computedElapsedTime [
	"Return elapsed time (a duration) since actual animation start of the current loop including delay"
	<return: #Duration>
	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the elapsed time' ].

	^ (self time now - self delayedStartTime) min: self duration
]

{ #category : #'api - accessing' }
BlBaseAnimation >> delay [
	"Return a delay duration which should be waited before animation actually starts"
	<return: #Duration>

	^ delay
]

{ #category : #'api - configuration' }
BlBaseAnimation >> delay: aDuration [
	self
		assert: [ aDuration >= 0 seconds ]
		description: [ 'Delay must not be negative' ].
	
	delay := aDuration asDuration
]

{ #category : #'api - time' }
BlBaseAnimation >> delayedStartTime [
	"Return a date and time at which animation is supposed to actually start taking delay into account"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the delayed start time' ].

	^ self startTime + self delay
]

{ #category : #'api - running' }
BlBaseAnimation >> doStep [
]

{ #category : #'api - accessing' }
BlBaseAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations.
	Note: My duration should not take my own delay into account"
	<return: #Duration>

	^ self subclassResponsibility
]

{ #category : #'time management' }
BlBaseAnimation >> elapsedTime [
	<return: #Duration>

	^ elapsedTime
]

{ #category : #'api - running' }
BlBaseAnimation >> enqueue [
	self target ifNotNil: [ :anElement | anElement enqueueTask: self ]
]

{ #category : #'event management accessing' }
BlBaseAnimation >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'private - running' }
BlBaseAnimation >> initStart [

	"new loop should start exactly when previous ends"
	startTime := self atLeastOneLoopDone
		ifTrue: [ self loopDoneTime ]
		ifFalse: [ self time now ].

	progress := 0.
	elapsedTime := 0 milliSeconds.
	isRunning := true.
	isStarted := true
]

{ #category : #initialization }
BlBaseAnimation >> initialize [
	super initialize.
	
	actionHandlers := OrderedCollection new.
	eventDispatcher := BlDirectEventDispatcher on: self.
	
	delay := 0 milliSeconds. "configurable"
	loop := 1. "configurable"
	
	time := BlTime real.

	self reset.
	
]

{ #category : #testing }
BlBaseAnimation >> isInfinite [
	"Return true if animation is infinite (has unlimited anount of loops)"
	<return: #Boolean>

	^ self loops isInfinite
]

{ #category : #testing }
BlBaseAnimation >> isRunning [
	^ isRunning
]

{ #category : #testing }
BlBaseAnimation >> isStarted [
	<return: #Boolean>

	^ isStarted
]

{ #category : #testing }
BlBaseAnimation >> isSubAnimation [
	"Return true if I am a sub animation, e.g. added to composite animation,
	false otherwise"
	<return: #Boolean>

	^ self parent isNotNil
]

{ #category : #'api - time' }
BlBaseAnimation >> loopDoneTime [
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the loop end time' ].
	
	self
		assert: [ self atLeastOneLoopDone ]
		description: [ 'Loop is not ended yet' ].

	^ loopDoneTime
]

{ #category : #'api - accessing' }
BlBaseAnimation >> loops [
	"Return how many times animation should be repeated.
	If animation is infinite, return 0"
	<return: #Number>

	^ loop
]

{ #category : #'api - configuration' }
BlBaseAnimation >> loops: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Amount of loops must not be negative' ].

	loop := aNumber
]

{ #category : #'api - time' }
BlBaseAnimation >> nextLoopStartTime [
	"Return a date and time at which the next animation repeat is supposed to start without taking delay of the next step into account"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the delayed start time' ].

	^ self delayedStartTime + self duration
]

{ #category : #'private - notifying' }
BlBaseAnimation >> notifyLoopDone [
	self dispatchEvent: BlAnimationLoopDoneEvent new
]

{ #category : #'private - notifying' }
BlBaseAnimation >> notifyOnFinishedHandlers [
	self onFinished.
	actionHandlers do: [ :each | each actionPerformed ]
]

{ #category : #hooks }
BlBaseAnimation >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.
	
	self time: aBlSpace time
]

{ #category : #'action  handling' }
BlBaseAnimation >> onFinished [
]

{ #category : #'action  handling' }
BlBaseAnimation >> onFinishedDo: aBlock [
	self addOnFinishedHandler: (BlOnActionHandler do: aBlock)
]

{ #category : #hooks }
BlBaseAnimation >> onLoopDone [
	"Is sent right after a current loop is done"

	loopDoneTime := self delayedStartTime + self duration.
	loopCount := loopCount + 1.

	self notifyLoopDone
]

{ #category : #'action  handling' }
BlBaseAnimation >> onStep [
	self fireEvent: (BlAnimationStepEvent new progress: progress)
]

{ #category : #accessing }
BlBaseAnimation >> parent [
	^ parent
]

{ #category : #accessing }
BlBaseAnimation >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
BlBaseAnimation >> printOn: aStream [
	super printOn: aStream.

	aStream
		space;
		nextPut: $(;
		nextPutAll: ((self progress * 100) roundTo: 0.01) asString;
		nextPut: $%;
		nextPut: $)
]

{ #category : #'api - accessing' }
BlBaseAnimation >> progress [
	"Return a normalized number within [0..1] representing animation progress.
	0 - means animation is not yet started.
	1 - animation loop is done"
	<return: #Number>

	^ progress
]

{ #category : #'api - running' }
BlBaseAnimation >> pulse [
	self 
		deprecated: 'Use run instead'
		on: 	'2 April 2018' 
		in: 'Pharo-6.0-60539-'.
	^ self run
]

{ #category : #'action  handling' }
BlBaseAnimation >> removeOnFinishedHandler: anActionHandler [
	actionHandlers remove: anActionHandler
]

{ #category : #'api - accessing' }
BlBaseAnimation >> repeats [
	"Return how many times animation was already repeated (loop count)"
	<return: #Number>

	^ loopCount
]

{ #category : #'private - testing' }
BlBaseAnimation >> requeueTaskAfterExecution [
	^ self isRunning
]

{ #category : #initialization }
BlBaseAnimation >> reset [	
	elapsedTime := 0 milliSeconds.
	startTime := nil.
	progress := 0.0.
	loopCount := 0.
	isRunning := false.
	isStarted := false.
	loopDoneTime := nil
]

{ #category : #'api - running' }
BlBaseAnimation >> run [
	self isStarted
		ifFalse: [ self start ].

	self isRunning
		ifFalse: [ ^ self ].

	self step.

	self shouldStop
		ifTrue: [ self stop ].

	"I am a sub-animation, so I am not registred as animation"
	self isSubAnimation
		ifTrue: [ ^ self ]
]

{ #category : #'private - testing' }
BlBaseAnimation >> shouldStartNextLoop [
	<return: #Boolean>

	^ self progress >= 1.0
		and: [ self canHaveNextLoop
			and: [ self time now > self nextLoopStartTime ] ]
]

{ #category : #'private - testing' }
BlBaseAnimation >> shouldStop [
	<return: #Boolean>

	^ self progress >= 1.0
		and: [ self canHaveNextLoop not ]
]

{ #category : #'api - running' }
BlBaseAnimation >> start [
	"self
		assert: [ self parent isNil ]
		description: [ 'A sub-animation has to be started from its parent' ]."
	
	self
		assert: [ self isRunning not ]
		description: [ 'Animation can not be start multiple times without stop' ].

	self initStart
]

{ #category : #'api - running' }
BlBaseAnimation >> startNextLoop [

	self initStart
]

{ #category : #pulse }
BlBaseAnimation >> startOn: aBlElement [
	"Start this animation with a given object playing a role of an animation target"
	
	self 
		deprecated: 'Use BlElement>>#addAnimation:'
		on: 	'2 April 2018' 
		in: 'Pharo-6.0-60539-'.
	
	aBlElement addAnimation: self
]

{ #category : #'api - time' }
BlBaseAnimation >> startTime [
	"Return a date and time at which the current animation loop was started"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the start time' ].

	^ startTime
]

{ #category : #'api - running' }
BlBaseAnimation >> step [
	
	self shouldStartNextLoop
		ifTrue: [ self startNextLoop ].

	"Time did not come for me to run because of delay"	
	self time now < self delayedStartTime
		ifTrue: [ ^ self ].

	elapsedTime := self computedElapsedTime.

	self
		assert: [ self duration isZero not ]
		description: [ 'Duration must not be zero' ].
	progress := (elapsedTime / self duration) asFloat.
	self
		assert: [ progress between: 0 and: 1 ]
		description: [ 'Progress must be within interval [0..1]' ].

	progress <= 1.0
		"Animation is not over yet, execute an actual animation step"
		ifTrue: [
			self doStep.
			self onStep ].

	progress >= 1
		ifTrue: [ self onLoopDone ].
		
	(self shouldStartNextLoop
		and: [ self time now > self nextLoopStartTime ])
			ifTrue: [ self step ]
]

{ #category : #'api - running' }
BlBaseAnimation >> stop [

	self
		assert: [ self isRunning ]
		description: [ 'Animation is not running' ].

	isRunning := false.

	"We have done an animation, notify listeners"
	self notifyOnFinishedHandlers
]

{ #category : #accessing }
BlBaseAnimation >> target [
	target ifNil:[ self parent ifNotNil:[:p| ^ p target]].
	^ target
]

{ #category : #accessing }
BlBaseAnimation >> target: anObject [
	target := anObject
]

{ #category : #accessing }
BlBaseAnimation >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #accessing }
BlBaseAnimation >> time: aBlTime [
	time := aBlTime
]
