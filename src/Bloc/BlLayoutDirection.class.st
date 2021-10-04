"
I represent an abstract layout direction.

There are left-to-right (LTR) and right-to-left (RTL) languages. Language direction influences the alignement of elments within layouts.
I do not have any logic and can only used as direction flag. Layouts that have direction specific logic should impelment their own object oriented mechanism

"
Class {
	#name : #BlLayoutDirection,
	#superclass : #Object,
	#classVars : [
		'leftToRight',
		'rightToLeft'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'class initialization' }
BlLayoutDirection class >> initialize [
	super initialize.
	
	leftToRight := BlLayoutLeftToRight new.
	rightToLeft := BlLayoutRightToLeft new
]

{ #category : #factory }
BlLayoutDirection class >> leftToRight [
	^ leftToRight
]

{ #category : #factory }
BlLayoutDirection class >> rightToLeft [
	^ rightToLeft
]

{ #category : #testing }
BlLayoutDirection >> isLeftToRight [
	^ self subclassResponsibility
]

{ #category : #testing }
BlLayoutDirection >> isRightToLeft [
	^ self subclassResponsibility
]

{ #category : #dispatch }
BlLayoutDirection >> of: anObject [
	^ self subclassResponsibility
]

{ #category : #enumerating }
BlLayoutDirection >> with: aCollection do: aBlock [
	^ self subclassResponsibility
]

{ #category : #enumerating }
BlLayoutDirection >> with: aCollection inject: thisValue into: binaryBlock [
	^ self subclassResponsibility
]
