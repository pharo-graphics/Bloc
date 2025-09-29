"
I am a special case of transparent background.
It is recommended to refer my unique instance since I am stateless and my superclass is immutable

"
Class {
	#name : #BlTransparentBackground,
	#superclass : #BlBackground,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #cleanup }
BlTransparentBackground class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlTransparentBackground class >> uniqueInstance [
	"Return a unique instance of transparent backgrond.
	It is preferable to use unique instance than create a new every time"
	<return: #BlBackground>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
BlTransparentBackground >> = anotherObject [
	"I do not take opacity into account"

	self == anotherObject ifTrue: [ ^ true ].
	^ anotherObject class = self class
]

{ #category : #testing }
BlTransparentBackground >> isTransparent [
	"I am transparent by definition"
	
	^ true
]

{ #category : #geometry }
BlTransparentBackground >> matchExtent: anExtent [
	"Do nothing for the transparent background"
]

{ #category : #accessing }
BlTransparentBackground >> opacity [

	^ 0.0
]

{ #category : #accessing }
BlTransparentBackground >> opacity: aNumber [
	"Ignore: I'm transparent."
]
