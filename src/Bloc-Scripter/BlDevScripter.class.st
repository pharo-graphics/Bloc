"
I help developers to script UI scenes and simplify exemplification process.

I am designed for Model-based User Interface Testing

"
Class {
	#name : #BlDevScripter,
	#superclass : #Object,
	#traits : 'TBlDevScripterActionStep + TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterActionStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#instVars : [
		'element',
		'space',
		'events',
		'rootStep',
		'eventHandler'
	],
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #accessing }
BlDevScripter class >> scripterDirectory [
	^ SystemResolver defaultLocalDirectory / 'scripter'
]

{ #category : #adding }
BlDevScripter >> addStep: aScripterStep [
	<return: #BlDevScripterStep>
	^ rootStep addStep: aScripterStep
]

{ #category : #'accessing - element' }
BlDevScripter >> assertElement: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Element must be a kind of ', BlElement name, ', it is: ', anElement printString ].
	self
		assert: [ element isNil ]
		description: [ 'Element can be initialized only once, there is already ', element printString,
			' and another element was about to be set: ', anElement printString ].
]

{ #category : #'private - asserting' }
BlDevScripter >> assertSpace: aSpace [
	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must be non-nil' ].
	self
		assert: [ aSpace host isKindOf: BlHeadlessHost ]
		description: [ 'Scripter space must have a ', BlHeadlessHost name,
			' kind of space, instead of ', aSpace host class ].
	self
		assert: [ element isNil ]
		description: [ 'Space must be initialized before the element ', element printString ]
]

{ #category : #'api - lifecycle' }
BlDevScripter >> close [

	space ifNotNil: [
		space close.
		space settle.
		space := nil ]
]

{ #category : #execution }
BlDevScripter >> continue [
	BlDevScripterStepContinueExecutor new
		scripter: self;
		async;
		"withScreenshots;"
		play
]

{ #category : #initialization }
BlDevScripter >> defaultSpace [

	^ BlSpace new
		  title: 'Scripter';
		  extent: 800 @ 600;
		  host: BlHeadlessHost default;
		  show;
		  yourself
]

{ #category : #'accessing - element' }
BlDevScripter >> element [
	^ element
]

{ #category : #'accessing - element' }
BlDevScripter >> element: anElement [

	self assertElement: anElement.

	element := anElement.

	anElement addEventFilter: eventHandler.

	anElement removeFromParent.
	space root addChild: anElement.
]

{ #category : #'accessing - element' }
BlDevScripter >> elementWithoutParent [
	"Return element removed from a testing ${class:BlSpace}$.
	Useful when someone wants to display the resulting element.
	It cannot be used during the script execution."
	<return: #BlElement>
	^ element removeFromParent
]

{ #category : #'private - accessing' }
BlDevScripter >> eventHandler [

	^ eventHandler
]

{ #category : #'accessing - data' }
BlDevScripter >> events [
	<return: #BlDevScripterEvents>

	^ events
]

{ #category : #'accessing - space' }
BlDevScripter >> extent [
	<return: #Point>
	^ space extent
]

{ #category : #'accessing - space' }
BlDevScripter >> extent: aPoint [
	space extent: aPoint
]

{ #category : #initialization }
BlDevScripter >> initialize [

	super initialize.
	events := BlDevScripterEvents new.

	rootStep := BlDevScripterRootStep new.
	rootStep referenceHere.

	eventHandler :=
		BlDevScripterEventCollectorHandler new
			scripter: self;
			yourself.

	space := self defaultSpace.
	space addEventFilter: eventHandler.
	space root addEventFilter: eventHandler
]

{ #category : #'accessing - data' }
BlDevScripter >> model [
	^ self userData model
]

{ #category : #'accessing - data' }
BlDevScripter >> model: anObject [
	self userData model: anObject
]

{ #category : #execution }
BlDevScripter >> play [
	BlDevScripterStepPlayOnceExecutor new
		scripter: self;
		async;
		"withScreenshots;"
		play
]

{ #category : #execution }
BlDevScripter >> pulse [

	self
		deprecated: 'Use #settle instead'
		transformWith: '`@receiver pulse' -> '`@receiver settle'.

	self settle
]

{ #category : #'accessing - space' }
BlDevScripter >> root [
	^ space root
]

{ #category : #execution }
BlDevScripter >> settle [
	space settle
]

{ #category : #accessing }
BlDevScripter >> showSpace [
	"I can be only used after Scripter execution."

	space
		close;
		settle;
		host: Bloc preferredHost;
		show
]

{ #category : #'accessing - space' }
BlDevScripter >> space [

	^ space
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceTasks [
	^ space taskQueue tasks
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceWithElement [
	"Return a space and ensure that the element is its child
	Useful when someone wants to display the resulting space (window) with the element.
	It cannot be used during the script execution."

	element space = space ifFalse: [
		space addChild: self elementWithoutParent ].
	^ space
]

{ #category : #execution }
BlDevScripter >> startWithExecutor: anExecutor [
	rootStep startWithExecutor: anExecutor
]

{ #category : #'steps - substeps' }
BlDevScripter >> substep: aLabel do: anOneArgBlock [
	^ (self substeps: aLabel do: anOneArgBlock) referenceSender
]

{ #category : #execution }
BlDevScripter >> syncContinue [
	BlDevScripterStepContinueExecutor new
		scripter: self;
		sync;
		"withScreenshots;"
		play
]

{ #category : #execution }
BlDevScripter >> syncPlay [
	BlDevScripterStepPlayOnceExecutor new
		scripter: self;
		sync;
		"withScreenshots;"
		play
]

{ #category : #'accessing - space' }
BlDevScripter >> time [
	<return: #BlTime>
	^ space time
]

{ #category : #'accessing - data' }
BlDevScripter >> userData [
	<return: #BlDevScripterUserData>
	^ space root devScripterData
]
