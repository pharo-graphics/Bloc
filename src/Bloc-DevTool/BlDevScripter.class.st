"
I help developers to script UI scenes and simplify exemplification process.

I am designed for Model-based User Interface Testing
"
Class {
	#name : #BlDevScripter,
	#superclass : #Object,
	#traits : 'TBlDevScripterStep',
	#classTraits : 'TBlDevScripterStep classTrait',
	#instVars : [
		'element',
		'space',
		'events',
		'rootStep'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
BlDevScripter >> addStep: aScripterStep [
	<return: #BlDevScripterStep>
	^ rootStep addStep: aScripterStep
]

{ #category : #actions }
BlDevScripter >> asyncContinue [
	BlUseAsyncFeatures disableDuring: [ self continue ].
]

{ #category : #tasks }
BlDevScripter >> check [
	^ self addStep: (BlDevScripterMultipleCheckStep new)
]

{ #category : #tasks }
BlDevScripter >> click [
	^ self addStep: (BlDevScripterClickStep new)
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
BlDevScripter >> gtEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtItemsFor: aView)
		title: 'Events'
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
BlDevScripter >> gtTreeFor: aView [
	<gtView>
	
	^ rootStep gtTreeFor: aView
]

{ #category : #initialization }
BlDevScripter >> initialize [
	super initialize.
	
	rootStep := BlDevScripterMultipleStep new.
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

{ #category : #tasks }
BlDevScripter >> substep [
	^ self addStep: (BlDevScripterMultipleStep new)
]

{ #category : #actions }
BlDevScripter >> syncPlay [
	BlUseAsyncFeatures disableDuring: [ self play ].
]

{ #category : #tasks }
BlDevScripter >> type [
	^ self addStep: BlDevScriptTypeTextStep new
]
