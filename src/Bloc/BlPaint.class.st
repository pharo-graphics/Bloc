"
I am the root class of all Paints in Bloc.
Paints are used for background, border, text fill or stroke.

All paints are meant to be immutable

"
Class {
	#name : #BlPaint,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Paint'
}

{ #category : #'instance creation' }
BlPaint class >> transparent [
	"Return a completely transparent paint"
	
	^ BlTransparentPaint uniqueInstance
]

{ #category : #converting }
BlPaint >> asBlBackground [

	^ BlBackground paint: self
]

{ #category : #converting }
BlPaint >> asBlPaint [
	^ self
]

{ #category : #comparing }
BlPaint >> hash [

	^ self class hash
]

{ #category : #testing }
BlPaint >> isColorPaint [

	^ false
]

{ #category : #testing }
BlPaint >> isOpaque [
	"Return true if I am opaque, false otherwise.
	It is important to implement paint specific logic in subclasses.
	If paint is opaque, we don't have to render elements behind it"

	^ false
]

{ #category : #testing }
BlPaint >> isTransparent [
	"Return true if I am transparent, false otherwise.
	It is important to implement paint specific logic in subclasses.
	If paint is transparent there is no need to render anything that uses it"

	^ false
]

{ #category : #geometry }
BlPaint >> matchExtent: anExtent [
	self subclassResponsibility
]
