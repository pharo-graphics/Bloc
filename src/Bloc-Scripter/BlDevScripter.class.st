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
		assert: [ self element isNil ] 
		description: [ 'Element can be initialized only once, there is already ', self element printString,
			' and another element was about to be set: ', anElement printString ].
]

{ #category : #'private - asserting' }
BlDevScripter >> assertSpace: aSpace [
	self 
		assert: [ aSpace isNotNil ] 
		description: [ 'Space must be non-nil' ].
	self 
		assert: [ aSpace host isKindOf: BlMockedHost ] 
		description: [ 'Scripter space must have a ', BlMockedHost name, 
			' kind of space, instead of ', aSpace host class ].
	self 
		assert: [ self element isNil ]
		description: [ 'Space must be initialized before the element ', self element printString ]
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
		  host: BlMockedHost new;
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

	anElement addEventFilter: self eventHandler.
	
	anElement removeFromParent.
	self space root addChild: anElement.
]

{ #category : #'accessing - element' }
BlDevScripter >> elementWithoutParent [
	"Return element removed from a testing ${class:BlSpace}$.
	Useful when someone wants to display the resulting element.
	It cannot be used during the script execution."
	<return: #BlElement>
	^ self element removeFromParent
]

{ #category : #'private - accessing' }
BlDevScripter >> eventHandler [
	<return: #BlDevScripterEventCollectorHandler>
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
	^ self space extent
]

{ #category : #'accessing - space' }
BlDevScripter >> extent: aPoint [
	self space extent: aPoint
]

{ #category : #initialization }
BlDevScripter >> initialize [
	super initialize.
	events := BlDevScripterEvents new.

	rootStep := BlDevScripterRootStep new.
	rootStep referenceHere.

	eventHandler := BlDevScripterEventCollectorHandler new scripter: self.

	space := self defaultSpace.
	self space addEventFilter: self eventHandler.
	self space root addEventFilter: self eventHandler
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
	self space pulse
]

{ #category : #'accessing - space' }
BlDevScripter >> root [
	^ self space root
]

{ #category : #accessing }
BlDevScripter >> showSpace [
	"I can be only used after Scripter execution."
	self space
		close;
		host: BlHost pickHost;
		show
]

{ #category : #'accessing - space' }
BlDevScripter >> space [

	^ space
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceTasks [
	^ self space taskQueue tasks
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceWithElement [
	"Return a space and ensure that the element is its child
	Useful when someone wants to display the resulting space (window) with the element.
	It cannot be used during the script execution."

	self element space = self space ifFalse: [ 
		self space addChild: self elementWithoutParent ].
	^ self space
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
	^ self space time
]

{ #category : #'accessing - data' }
BlDevScripter >> userData [
	<return: #BlDevScripterUserData>
	^ self space root devScripterData
]
