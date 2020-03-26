"
Overlay element relocates and resizes itself to have exactly the same bounds as some reference element.

[[[
element := BlElement new.
overlay := BlOverlayElement on: element.
container addChild: overlay.
]]]


"
Class {
	#name : #BlOverlayElement,
	#superclass : #BlElement,
	#instVars : [
		'overlayListener',
		'referenceElement'
	],
	#category : #'Bloc-Utilities - Overlay'
}

{ #category : #'instance creation' }
BlOverlayElement class >> on: anElement [
	^ self new attachTo: anElement
]

{ #category : #'api - attaching / detaching' }
BlOverlayElement >> attachTo: anElement [
	
	referenceElement = anElement
		ifTrue: [ ^ self ].
	
	self isAttached 
		ifTrue: [ self detach ].
	
	referenceElement := anElement.
	anElement addEventHandler: overlayListener
]

{ #category : #'api - attaching / detaching' }
BlOverlayElement >> detach [
	
	self isAttached
		ifFalse: [ ^ self ].
	
	referenceElement removeEventHandler: overlayListener.
	referenceElement := nil
]

{ #category : #initialization }
BlOverlayElement >> initialize [
	super initialize.
	
	overlayListener := BlOverlayListener for: self.
	self constraintsDo: [ :c |
		c ignoreByLayout.
		c infinite holder startIgnoring ].
	self preventMouseEvents
]

{ #category : #'api - testing' }
BlOverlayElement >> isAttached [
	"Return true if I am attached to any element, false otherwise"
	<return: #Boolean>

	^ referenceElement isNotNil
]

{ #category : #layout }
BlOverlayElement >> measureMyBounds [
	"I compute by position and size in relation to the reference element"
	self
		assert: [ self isAttached ]
		description: [ 'I must be attached to the reference element to measure myself' ].
		
	self relocate: (overlayListener positionFor: referenceElement).
	self size: (overlayListener extentFor: referenceElement).
]

{ #category : #layout }
BlOverlayElement >> onMeasure: anExtentMeasurementSpec [

	self isAttached
		ifTrue: [ self measureMyBounds ].

	super onMeasure: anExtentMeasurementSpec
]
