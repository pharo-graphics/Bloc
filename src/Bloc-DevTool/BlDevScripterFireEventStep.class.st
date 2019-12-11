Class {
	#name : #BlDevScripterFireEventStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'event',
		'position'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterFireEventStep >> defaultLabel [
	^ self event
		ifNotNil: [ :anEvent | 'Fire ', anEvent className ] 
		ifNil: [ self ]
]

{ #category : #'accessing - event' }
BlDevScripterFireEventStep >> event [
	<return: #BlEvent>
	^ event
]

{ #category : #'accessing - event' }
BlDevScripterFireEventStep >> event: anEvent [
	self 
		assert: [ anEvent isKindOf: BlEvent ] 
		description: [ 'Event must be kind of ', BlEvent name ].
	event := anEvent
]

{ #category : #'accessing - event' }
BlDevScripterFireEventStep >> eventOfClass: anEventClass [
	self event: anEventClass new
]

{ #category : #'accessing - position' }
BlDevScripterFireEventStep >> inCenter [
	self position: BlDevScripterEventCenteredPosition new
]

{ #category : #initialization }
BlDevScripterFireEventStep >> initialize [
	super initialize.
	position := BlDevScripterEventPosition new.
]

{ #category : #'accessing - event' }
BlDevScripterFireEventStep >> mouseOut [
	self eventOfClass: BlMouseOutEvent
]

{ #category : #'accessing - event' }
BlDevScripterFireEventStep >> mouseOver [
	self eventOfClass: BlMouseOverEvent
]

{ #category : #'accessing - position' }
BlDevScripterFireEventStep >> outside [
	self position: BlDevScripterEventOutsidePosition new
]

{ #category : #actions }
BlDevScripterFireEventStep >> playOn: aScripter [
	| aTarget |
	aTarget := self target findTargetIn: aScripter element.
	self position updateEventPosition: self event in: aTarget.
	BlEvent fireEvent: self event target: aTarget.
	aScripter pulse.
]

{ #category : #'accessing - position' }
BlDevScripterFireEventStep >> position [
	<return: #BlDevScripterEventPosition>
	^ position
]

{ #category : #'accessing - position' }
BlDevScripterFireEventStep >> position: aBlDevScripterEventPosition [
	position := aBlDevScripterEventPosition
]
