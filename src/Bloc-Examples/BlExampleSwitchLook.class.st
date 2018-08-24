Class {
	#name : #BlExampleSwitchLook,
	#superclass : #BlElementEventListener,
	#instVars : [
		'widget',
		'color'
	],
	#category : 'Bloc-Examples-Widgets'
}

{ #category : #accessing }
BlExampleSwitchLook >> color [
	^ color
]

{ #category : #accessing }
BlExampleSwitchLook >> color: aColor [
	color := aColor.
	widget ifNil: [ ^ self ].
	self updateColor
]

{ #category : #initialization }
BlExampleSwitchLook >> defaultColor [
	^ Color fromHexString: '04e9fe'
]

{ #category : #'event handling' }
BlExampleSwitchLook >> handleEvent: anEvent [
	super handleEvent: anEvent.
	
	(anEvent isKindOf: BlExampleSwitchEventActivated)
		ifTrue: [ self switchActivated ].
	(anEvent isKindOf: BlExampleSwitchEventDeactivated)
		ifTrue: [ self switchDeactivated ].
]

{ #category : #initialization }
BlExampleSwitchLook >> initialize [
	super initialize.
	
	color := self defaultColor
]

{ #category : #initialization }
BlExampleSwitchLook >> initializeSkin [
]

{ #category : #installation }
BlExampleSwitchLook >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	
	widget := anElement.
	widget removeChildren.
	self initializeSkin.

	widget isActivated
		ifTrue: [ self switchActivated ]
		ifFalse: [ self switchDeactivated ]
]

{ #category : #'event handling' }
BlExampleSwitchLook >> switchActivated [
]

{ #category : #'event handling' }
BlExampleSwitchLook >> switchDeactivated [
]

{ #category : #updating }
BlExampleSwitchLook >> updateColor [
]
