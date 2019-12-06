"
I help developers to script UI scenes and simplify exemplification process.

I am designed for Model-based User Interface Testing
"
Class {
	#name : #BlDevScripter,
	#superclass : #Object,
	#instVars : [
		'element',
		'space',
		'rootTask',
		'events'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
BlDevScripter >> check [
	^ rootTask addTask: (BlDevScripterMultipleCheckTask new)
]

{ #category : #tasks }
BlDevScripter >> click [
	^ rootTask addTask: (BlDevScripterClickTask new)
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
	^ space gtPreviewFor: aView
]

{ #category : #'gt-extension' }
BlDevScripter >> gtTreeFor: aView [
	<gtView>
	
	^ rootTask gtTreeFor: aView
]

{ #category : #initialization }
BlDevScripter >> initialize [
	super initialize.
	
	rootTask := BlDevScripterCompositeTask new.
	space := BlSpace new.
	events := OrderedCollection new
]

{ #category : #actions }
BlDevScripter >> play [
	self pulse.
	rootTask playOn: self
]

{ #category : #actions }
BlDevScripter >> pulse [
	space pulse
]
