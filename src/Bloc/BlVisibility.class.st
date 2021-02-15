"
I represent a visibility type and can be
	""gone"" - element is not visible and does not take any space in layout
	""hidden"" - element is not visible but participates in layout
	""visible"" - normal visiblity

Visibility is independent from opacity, which is just a visual property.
Invisible (gone or hidden) elements don't receive event, while transparent (opacity = 0) do receive.

If you want to make element transparent and preserve ability to handle events set opacity to zero:
==element opacity: 0==
"
Class {
	#name : #BlVisibility,
	#superclass : #Object,
	#classInstVars : [
		'gone',
		'hidden',
		'visible'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #cleanup }
BlVisibility class >> cleanUp [
	super cleanUp.
	
	gone := nil.
	hidden := nil.
	visible := nil
]

{ #category : #visibilities }
BlVisibility class >> gone [
	^ gone ifNil: [ gone := BlVisibilityGone new ]
]

{ #category : #visibilities }
BlVisibility class >> hidden [
	^ hidden ifNil: [ hidden := BlVisibilityHidden new ]
]

{ #category : #visibilities }
BlVisibility class >> visible [
	^ visible ifNil: [ BlVisibilityVisible new ]
]

{ #category : #comparing }
BlVisibility >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlVisibility >> hash [
	^ self class hash
]

{ #category : #testing }
BlVisibility >> isGone [
	^ false
]

{ #category : #testing }
BlVisibility >> isHidden [
	^ false
]

{ #category : #testing }
BlVisibility >> isVisible [
	^ false
]

{ #category : #testing }
BlVisibility >> shouldDraw [
	^ self isVisible
]

{ #category : #testing }
BlVisibility >> shouldLayout [
	^ self isVisible and: [ self isGone not ]
]

{ #category : #testing }
BlVisibility >> shouldMeasure [
	^ self isVisible
]
