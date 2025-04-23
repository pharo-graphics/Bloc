"
Overlay element relocates and resizes itself to have exactly the same bounds as some reference element.

```
element := BlElement new.
overlay := BlOverlayElement on: element.
container addChild: overlay.
```


"
Class {
	#name : #BlOverlayElement,
	#superclass : #BlElement,
	#instVars : [
		'overlayListener',
		'referenceElement'
	],
	#category : #'Bloc-Overlay'
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

{ #category : #'hook - geometry' }
BlOverlayElement >> extentFrom: anExtent [

	^ anExtent
]

{ #category : #initialization }
BlOverlayElement >> initialize [
	super initialize.
	
	overlayListener := self newOverlayListener.
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

{ #category : #initialization }
BlOverlayElement >> newOverlayListener [

	^ BlOverlayListener for: self
]

{ #category : #'hooks - children' }
BlOverlayElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self isAttached
		ifFalse: [ ^ self ].
		
	overlayListener relocateTo: referenceElement.
	overlayListener resizeTo: referenceElement.
]

{ #category : #'hook - geometry' }
BlOverlayElement >> positionFrom: aPosition [

	^ aPosition
]
