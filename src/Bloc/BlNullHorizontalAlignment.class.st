Class {
	#name : #BlNullHorizontalAlignment,
	#superclass : #BlNullAlignment,
	#classInstVars : [
		'rightToLeft',
		'leftToRight'
	],
	#category : #'Bloc-Layouts-Alignment'
}

{ #category : #factory }
BlNullHorizontalAlignment class >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : #'class initialization' }
BlNullHorizontalAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #'class initialization' }
BlNullHorizontalAlignment class >> initializeSingletons [

	super initializeSingletons.

	rightToLeft := BlNullRightAlignment new.
	leftToRight := BlNullLeftAlignment new
]

{ #category : #factory }
BlNullHorizontalAlignment class >> leftToRight [
	^ leftToRight
]

{ #category : #factory }
BlNullHorizontalAlignment class >> rightToLeft [
	^ rightToLeft
]

{ #category : #composition }
BlNullHorizontalAlignment >> + aVerticalAlignment [
	^ BlCompositeAlignment horizontal: self vertical: aVerticalAlignment
]

{ #category : #factory }
BlNullHorizontalAlignment >> directed: aBlLayoutDirection [
	^ self class directed: aBlLayoutDirection
]

{ #category : #factory }
BlNullHorizontalAlignment >> leftToRight [
	^ self class leftToRight
]

{ #category : #factory }
BlNullHorizontalAlignment >> rightToLeft [
	^ self class rightToLeft
]

{ #category : #translation }
BlNullHorizontalAlignment >> translationOf: aBounds in: aContainerBounds [
	^ 0 @ 0
]
