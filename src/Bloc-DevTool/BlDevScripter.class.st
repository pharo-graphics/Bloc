"
I help developers to script UI scenes and simplify exemplification process
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

{ #category : #'as yet unclassified' }
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
