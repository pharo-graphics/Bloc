"
I am a special transparent case of a color paint.

Most of the elements have transparent backgrounds or stroke.
It is prefereable to refer my unique instance, since I am stateless

"
Class {
	#name : #BlTransparentPaint,
	#superclass : #BlColorPaint,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Paint'
}

{ #category : #cleanup }
BlTransparentPaint class >> cleanUp [

	super cleanUp.

	uniqueInstance := nil
]

{ #category : #'instance creation' }
BlTransparentPaint class >> color: aColor [

	self shouldNotImplement
]

{ #category : #'instance creation' }
BlTransparentPaint class >> transparent [
	self shouldNotImplement
]

{ #category : #accessing }
BlTransparentPaint class >> uniqueInstance [
	"Return a unique instance of transparent paint.
	It is preferable to use unique instance than create a new every time"

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlTransparentPaint >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	^ (anotherObject isKindOf: self class)
]

{ #category : #accessing }
BlTransparentPaint >> color: aColor [

	self shouldNotImplement
]

{ #category : #initialization }
BlTransparentPaint >> initialize [

	super initialize.

	color := Color transparent
]

{ #category : #testing }
BlTransparentPaint >> isOpaque [
	"I am transparent by definition and therefore always return false"

	^ false
]

{ #category : #testing }
BlTransparentPaint >> isTransparent [
	"I am transparent by definition and therefore always return true"

	^ true
]
