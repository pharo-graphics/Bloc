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
	#category : #'Bloc-DevTool-Scripter'
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
		host: BlMockedHost new.
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
	
	anElement space = self space ifTrue: [ ^ self ].
	
	anElement removeFromParent.
	self space addChild: anElement.
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

{ #category : #'gt-extension' }
BlDevScripter >> gtElementsFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Children';
		object: [ self space root ];
		view: #gtChildrenFor:
]

{ #category : #'gt-extension' }
BlDevScripter >> gtEventTracesIn: aContainer [
	| anEventColor |
	
	anEventColor := Color r: 0.270772238514174 g: 0.6705767350928641 b: 0.9960899315738025 alpha: 1.0.
	
	self events do: [ :eachEvent |
		eachEvent class = BlMouseDownEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircle new);
					size: 6@6;
					background: anEventColor;
					effect: (BlGaussianShadowEffect
						color: anEventColor
						width: 1
						offset: 0@0);
					border: (BlBorder paint: Color white width: 1);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlMouseUpEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircle new);
					size: 6@6;
					background: Color white;
					border: (BlBorder paint: anEventColor width: 1);
					effect: (BlGaussianShadowEffect
						color: anEventColor
						width: 1
						offset: 0@0);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlClickEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircle new);
					size: 12@12;
					background: Color transparent;
					border: (BlBorder paint: anEventColor width: 1);
					relocate: eachEvent position - (6@6)) ].
		
		eachEvent class = BlMouseMoveEvent
			ifTrue: [
				aContainer addChild: (BlLineElement new
					border: (BlBorder paint: anEventColor width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: eachEvent position - eachEvent delta);
					toAnchor: (BlAbsolutePositionAnchor position: eachEvent position)) ] ]
]

{ #category : #'gt-extension' }
BlDevScripter >> gtEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtEventsFor: aView)
		title: 'Events';
		priority: 3
]

{ #category : #'gt-extension' }
BlDevScripter >> gtReveresedEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtReveresedEventsFor: aView)
		title: 'Events (Reversed)';
		priority: 4
]

{ #category : #'gt-extension' }
BlDevScripter >> gtSpaceFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
		
	^ aView explicit
		title: 'Preview';
		priority: 0;
		stencil: [
			| aContainer |
			
			aContainer := BlElement new.
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			(self space gtPreviewFor: GtPhlowEmptyView new)
				asElementDo: [ :anElement | aContainer addChild: anElement ].
			
			self gtEventTracesIn: aContainer.
			
			aContainer ];
		actionButtonLabel: 'Open' 
			tooltip: 'Open scripter space in a real window'
			action: [ self showSpace ];
		actionButtonLabel: 'Inspect'
			tooltip: 'Inspect element (remove it from the Scripter space)' 
			action: [ :anElement | 
				anElement phlow spawnObject: self elementWithoutParent ]
]

{ #category : #'gt-extension' }
BlDevScripter >> gtSpaceTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self spaceTasks ifEmpty: [ ^ aView empty ].
	^ (self spaceTasks gtItemsFor: aView)
		title: 'Space Tasks'
]

{ #category : #'gt-extension' }
BlDevScripter >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsMondrianTreeFor: aView
]

{ #category : #'gt-extension' }
BlDevScripter >> gtStepsTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsTreeFor: aView
]

{ #category : #'gt-extension' }
BlDevScripter >> gtUserDataFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self userData isEmpty ifTrue: [ ^ aView empty ].
	^ (self userData gtUserDataFor: aView)
		priority: 7
]

{ #category : #initialization }
BlDevScripter >> initialize [
	super initialize.
	
	events := BlDevScripterEvents new.

	rootStep := BlDevScripterRootStep new.
	rootStep referenceHere.

	eventHandler := BlDevScripterEventCollectorHandler new scripter: self.

	space := self defaultSpace.
	self subscribeToSpace.
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
	<return: #BlSpace>
	^ space
]

{ #category : #'accessing - space' }
BlDevScripter >> space: aSpace [
	self assertSpace: aSpace.
	self unsubscribeFromSpace.
	space := aSpace.
	self subscribeToSpace.
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceTasks [
	^ self space taskQueue tasks
]

{ #category : #'accessing - space' }
BlDevScripter >> spaceWithElement [
	"Return ${class:BlSpace}$ and ensure that the ==element== is its child
	Useful when someone wants to display the resulting space (window) with the element.
	It cannot be used during the script execution."
	<return: #BlSpace>
	self element space = self space ifFalse: [ 
		self space addChild: self elementWithoutParent ].
	^ self space
]

{ #category : #execution }
BlDevScripter >> startWithExecutor: anExecutor [
	rootStep startWithExecutor: anExecutor
]

{ #category : #'private - subscriptions' }
BlDevScripter >> subscribeToSpace [
	self space addEventFilter: self eventHandler.
	self space root addEventFilter: self eventHandler.
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

{ #category : #'private - subscriptions' }
BlDevScripter >> unsubscribeFromSpace [
	self space ifNil: [ ^ self ].
	self space removeEventFilter: self eventHandler.
	self space root removeEventFilter: self eventHandler.
]

{ #category : #'accessing - data' }
BlDevScripter >> userData [
	<return: #BlDevScripterUserData>
	^ self space root devScripterData
]
