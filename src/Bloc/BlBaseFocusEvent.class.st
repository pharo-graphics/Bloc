Class {
	#name : #BlBaseFocusEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'reason'
	],
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlBaseFocusEvent >> asBlurEvent [
	^ BlBlurEvent new
		copyFrom: self;
		yourself
]

{ #category : #converting }
BlBaseFocusEvent >> asFocusInEvent [
	^ BlFocusInEvent new
		copyFrom: self;
		canBePropagated: false;
		yourself
]

{ #category : #converting }
BlBaseFocusEvent >> asFocusOutEvent [
	^ BlFocusOutEvent new
		copyFrom: self;
		canBePropagated: false;
		yourself
]

{ #category : #initialization }
BlBaseFocusEvent >> initialize [
	super initialize.

	reason := BlFocusUnknownReason uniqueInstance
]

{ #category : #testing }
BlBaseFocusEvent >> isBaseFocus [
	^ true
]

{ #category : #testing }
BlBaseFocusEvent >> isDueToRemoval [
	^ self reason = BlFocusDueToRemovedFromParentReason uniqueInstance
		or: [ self reason = BlFocusDueToRemovedFromSpaceReason uniqueInstance ]
]

{ #category : #accessing }
BlBaseFocusEvent >> reason [
	<return: #BlFocusReason>

	^ reason
]

{ #category : #accessing }
BlBaseFocusEvent >> reason: aBlFocusReason [
	reason := aBlFocusReason
]
