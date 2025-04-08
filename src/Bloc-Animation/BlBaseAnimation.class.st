"
I represent the most general concept of `BlElement` animation. Instances of my concrete subclasses are Bloc element animations.

These are some basic properties of an animation:
- `loops`: The number of loops to execute an animation, or `Float infinite` for an endless animation.
- `delay`: How much time to pospone the ""actual start"" after it is added.
- `duration`: How much time will last the animation after its ""actual start"" (`start` time + `delay`).


## Execution

An animation can be added to an element via `BlElement>>#addAnimation:`. From that moment, such element is considered the `target` of the animation. When added to an element that **is attached** to a space, the animation will be directly enqueued into it. 
If the element was **not attached** to a space, the animation will stay stopped until the element attachs, and the enqueued tasks transfered to the space.

To understand the execution model, it's important to note that an animation is a `BlTask`.
When a task is added to a space, a pulse is requested. At some point, the space host's universe should pulse, and all enqueued tasks be executed. Each pulse makes progress each enqueued animation by executing `#doStep`. Animations will be re-enqueued in the space's task queue unless the animation is finished.

An animation can finish either because last loop is done, or because `#stop` was sent. The instance cant be reused as happens with any `BlTask`.


## Composition

Animations may be composed (see `BlCompositeAnimation`). This relationship is represented in the `#parent` property.
Only a root animation can be added to an element via `BlElement>>#addAnimation:`.
Such element will be considered, in that case, the target of all its sub-animations, too.

"
Class {
	#name : #BlBaseAnimation,
	#superclass : #BlTask,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
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
		'loopDoneTime',
		'loops',
		'announcer'
	],
	#category : #'Bloc-Animation-Basic'
}

{ #category : #'event management accessing' }
BlBaseAnimation >> announcer [

	^ announcer
]

{ #category : #'private - testing' }
BlBaseAnimation >> atLeastOneLoopDone [
	
	^ loopDoneTime isNotNil
]

{ #category : #'api - configuration' }
BlBaseAnimation >> beInfinite [

	loops := nil
]

{ #category : #'private - testing' }
BlBaseAnimation >> canHaveNextLoop [

	^ self isInfinite or: [ loopCount < loops ]
]

{ #category : #'api - accessing' }
BlBaseAnimation >> delay [
	"Return a delay duration which should be waited before animation actually starts"

	^ delay
]

{ #category : #'api - configuration' }
BlBaseAnimation >> delay: aDuration [
	"Establish the delay to wait before animation actually starts.
	The duration must not be negative."
	
	delay := aDuration
]

{ #category : #'api - time' }
BlBaseAnimation >> delayedStartTime [
	"Return a `DateAndTime` at which this animation should start, taking delay into account.
	Precondition: `self isStarted = true`."

	^ self startTime + self delay
]

{ #category : #'api - running' }
BlBaseAnimation >> doStep [
	"Execute an actual animation step. My subclasses define this hook, and assume it's executed after my internal state has been updated, for example, progress."

	self subclassResponsibility
]

{ #category : #'api - accessing' }
BlBaseAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations.
	Note: My duration should not take my own delay into account"

	^ self subclassResponsibility
]

{ #category : #'time management' }
BlBaseAnimation >> elapsedTime [

	^ elapsedTime
]

{ #category : #'api - running' }
BlBaseAnimation >> enqueue [

	self target ifNotNil: [ :aBlElement | aBlElement enqueueTask: self ]
]

{ #category : #'private - running' }
BlBaseAnimation >> initStart [

	"new loop should start exactly when previous ends"
	startTime := self atLeastOneLoopDone
		ifTrue: [ loopDoneTime ]
		ifFalse: [ time now ].

	progress := 0.0.
	elapsedTime := 0 milliSeconds.
	isRunning := true.
	isStarted := true
]

{ #category : #initialization }
BlBaseAnimation >> initialize [

	super initialize.
	
	announcer := Announcer new.
	
	delay := 0 milliSeconds.
	loops := 1.
	
	time := BlTime real.

	self reset
]

{ #category : #testing }
BlBaseAnimation >> isInfinite [
	"Return whether this animation is infinite, i.e. has unlimited amount of loops."

	^ loops isNil
]

{ #category : #testing }
BlBaseAnimation >> isRunning [

	^ isRunning
]

{ #category : #testing }
BlBaseAnimation >> isStarted [

	^ isStarted
]

{ #category : #testing }
BlBaseAnimation >> isSubAnimation [
	"Return true if I am a sub animation, e.g. added to composite animation,
	false otherwise"

	^ self parent isNotNil
]

{ #category : #'api - accessing' }
BlBaseAnimation >> loopCount [
	"Return how many times animation was already repeated (loop count)"

	^ loopCount
]

{ #category : #'api - time' }
BlBaseAnimation >> loopDoneTime [
	"Answer a `DateAndTime` indicating the last time a loop ended.
	Preconditions: Requires #atLeastOneLoopDone to be true."

	^ loopDoneTime
]

{ #category : #'api - accessing' }
BlBaseAnimation >> loops [
	"Return how many times animation should be repeated.
	If animation is infinite, return `nil`."

	^ loops
]

{ #category : #'api - configuration' }
BlBaseAnimation >> loops: aPositiveNumber [
	"Establish how many times animation should be repeated."

	loops := aPositiveNumber
]

{ #category : #'api - time' }
BlBaseAnimation >> nextLoopStartTime [
	"Return a `DateAndTime` at which the next animation repeat is supposed to start without taking delay of the next step into account.
	Precondition: #isStarted to be true."

	^ self delayedStartTime + self duration
]

{ #category : #'private - notifying' }
BlBaseAnimation >> notifyLoopDone [

	announcer announce:
		(BlAnimationLoopDoneAnnouncement new
			animation: self;
			progress: progress;
			loopCount: loopCount;
			timestamp: loopDoneTime;
			yourself)
]

{ #category : #'private - notifying' }
BlBaseAnimation >> notifyOnFinishedHandlers [

	self onFinished.
	
	announcer announce:
		(BlAnimationStoppedAnnouncement new
			animation: self;
			progress: progress;
			timestamp: time now;
			yourself)
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

	announcer
		when: BlAnimationStoppedAnnouncement 
		do: aBlock
		for: self
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

	announcer announce:
		(BlAnimationStepAnnouncement new
			animation: self;
			progress: progress;
			timestamp: time now;
			yourself)
]

{ #category : #accessing }
BlBaseAnimation >> parent [

	^ parent
]

{ #category : #accessing }
BlBaseAnimation >> parent: anotherAnimation [

	parent := anotherAnimation
]

{ #category : #printing }
BlBaseAnimation >> printOn: aStream [
	super printOn: aStream.

	aStream
		space;
		nextPut: $(;
		nextPutAll: ((progress * 100) printShowingDecimalPlaces: 2);
		nextPut: $%;
		nextPut: $)
]

{ #category : #'api - accessing' }
BlBaseAnimation >> progress [
	"Return a normalized number within [0..1] representing animation progress.
	0 - means animation is not yet started.
	1 - animation loop is done"

	^ progress
]

{ #category : #'private - testing' }
BlBaseAnimation >> requeueTaskAfterExecution [

	^ isRunning
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

	isStarted ifFalse: [ self start ].
	isRunning ifFalse: [ ^ self ].

	self step.

	self shouldStop ifTrue: [ self stop ].

]

{ #category : #'private - testing' }
BlBaseAnimation >> shouldStartNextLoop [

	^ progress >= 1.0
		and: [ self canHaveNextLoop
			and: [ time now > self nextLoopStartTime ] ]
]

{ #category : #'private - testing' }
BlBaseAnimation >> shouldStop [

	^ progress >= 1.0 and: [ self canHaveNextLoop not ]
]

{ #category : #'api - running' }
BlBaseAnimation >> start [

	"Ignore if it's already started"
	isRunning ifTrue: [ ^ self ].

	self initStart
]

{ #category : #'api - time' }
BlBaseAnimation >> startTime [
	"Return a ´DateAndTime´ at which the current animation loop was started.
	Precondition: `self isStarted = true`"

	^ startTime
]

{ #category : #'api - running' }
BlBaseAnimation >> step [

	| actualElapsedTime |

	self shouldStartNextLoop ifTrue: [ self initStart ].

	actualElapsedTime := time now - self delayedStartTime.

	"Time did not come for me to run because of delay"	
	actualElapsedTime negative ifTrue: [ ^ self ].

	actualElapsedTime >= self duration
		ifTrue: [
			elapsedTime := self duration.
			progress := 1.0 ]
		ifFalse: [
			elapsedTime := actualElapsedTime.
			progress := (elapsedTime / self duration) asFloat ].

	self doStep.
	self onStep.

	progress = 1.0 ifTrue: [ self onLoopDone ].

	"Multiple steps may have passed"
	(self shouldStartNextLoop and: [
		time now > self nextLoopStartTime ])
			ifTrue: [ self step ]
]

{ #category : #'api - running' }
BlBaseAnimation >> stop [

	"Ignore if it's already stopped"
	isRunning ifFalse: [ ^ self ].

	isRunning := false.

	"We have done an animation, notify listeners"
	self notifyOnFinishedHandlers
]

{ #category : #accessing }
BlBaseAnimation >> target [

	^ target ifNil: [ parent ifNotNil: [ :p | p target ] ]
]

{ #category : #accessing }
BlBaseAnimation >> target: aBlElement [

	target := aBlElement
]

{ #category : #accessing }
BlBaseAnimation >> time [
	"Answer the `BlTime` that I query to calculate progress."
	
	^ time
]

{ #category : #accessing }
BlBaseAnimation >> time: aBlTime [

	time := aBlTime
]

{ #category : #'action  handling' }
BlBaseAnimation >> whenStepDo: aBlock [

	announcer
		when: BlAnimationStepAnnouncement
		do: aBlock
		for: self
]
