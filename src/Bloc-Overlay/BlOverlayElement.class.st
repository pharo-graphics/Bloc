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
	#traits : 'TBlOverlayElement',
	#classTraits : 'TBlOverlayElement classTrait',
	#category : #'Bloc-Overlay'
}

{ #category : #'instance creation' }
BlOverlayElement class >> on: anElement [
	^ self new attachTo: anElement
]

{ #category : #initialization }
BlOverlayElement >> initialize [

	super initialize.
	self initializeAsOverlayElement.
	self preventMouseEvents
]
