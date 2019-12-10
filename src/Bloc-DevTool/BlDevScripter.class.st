"
I help developers to script UI scenes and simplify exemplification process.

I am designed for Model-based User Interface Testing
"
Class {
	#name : #BlDevScripter,
	#superclass : #Object,
	#traits : 'TBlDevScripterActionStep',
	#classTraits : 'TBlDevScripterActionStep classTrait',
	#instVars : [
		'element',
		'space',
		'events',
		'rootStep'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #adding }
BlDevScripter >> addStep: aScripterStep [
	<return: #BlDevScripterStep>
	^ rootStep addStep: aScripterStep
]

{ #category : #actions }
BlDevScripter >> continue [
	self pulse.
	rootStep continueOn: self
]

{ #category : #accessing }
BlDevScripter >> element [
	^ element
]

{ #category : #accessing }
BlDevScripter >> element: anElement [
	element := anElement.
	element removeFromParent.
	
	element addEventFilterOn: BlEvent do: [ :anEvent | events add: anEvent copy ].

	space addChild: element.
]

{ #category : #accessing }
BlDevScripter >> elementWithoutParent [
	"Return element removed from a testing ${class:BlSpace}$.
	Useful when someone wants to display the resulting element.
	It cannot be used during the script execution."
	<return: #BlElement>
	^ self element removeFromParent
]

{ #category : #accessing }
BlDevScripter >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : #'gt-extension' }
BlDevScripter >> gtElementsFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Children';
		items: [ space root children ];
		children: #children;
		expandUpTo: 3
]

{ #category : #'gt-extension' }
BlDevScripter >> gtEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtItemsFor: aView)
		title: 'Events';
		priority: 3
]

{ #category : #'gt-extension' }
BlDevScripter >> gtReveresedEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events reversed gtItemsFor: aView)
		title: 'Events (Reversed)';
		priority: 4
]

{ #category : #'gt-extension' }
BlDevScripter >> gtSpaceFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	^ (space gtPreviewFor: aView)
		actionButtonLabel: 'Open' 
			action: [ self spaceWithElement show ];
		actionButtonLabel: 'Inspect' 
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
	
	rootStep := BlDevScripterMultipleActionStep new.
	space := BlSpace new.
	space title: 'Scripter'.
	space extent: 800 @ 600.
	events := OrderedCollection new
]

{ #category : #actions }
BlDevScripter >> play [
	self pulse.
	rootStep playIndicatingStateOn: self
]

{ #category : #actions }
BlDevScripter >> pulse [
	space pulse
]

{ #category : #accessing }
BlDevScripter >> spaceTasks [
	^ space taskQueue tasks
]

{ #category : #accessing }
BlDevScripter >> spaceWithElement [
	"Return ${class:BlSpace}$ and ensure that the ==element== is its child
	Useful when someone wants to display the resulting space (window) with the element.
	It cannot be used during the script execution."
	<return: #BlSpace>
	self element space = space ifFalse: [ 
		space addChild: self elementWithoutParent ].
	^ space
]

{ #category : #'steps - storing' }
BlDevScripter >> storeAt: aSymbol elementInfo: anOneArgBlock [
	^ self addStep: (BlDevScripterStoreElementInfoStep new
		key: aSymbol;
		block: anOneArgBlock)
]

{ #category : #'steps - subactions' }
BlDevScripter >> substep [
	^ self addStep: (BlDevScripterMultipleActionStep new)
]

{ #category : #actions }
BlDevScripter >> syncContinue [
	BlUseAsyncFeatures disableDuring: [ self continue ].
]

{ #category : #actions }
BlDevScripter >> syncPlay [
	BlUseAsyncFeatures disableDuring: [ self play ].
]

{ #category : #accessing }
BlDevScripter >> userData [
	<return: #BlDevScripterUserData>
	^ space root devScripterData
]
