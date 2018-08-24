Class {
	#name : #BlGridOrientation,
	#superclass : #Object,
	#classVars : [
		'HORIZONTAL',
		'VERTICAL'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #factory }
BlGridOrientation class >> horizontal [
	^ HORIZONTAL
]

{ #category : #'class initialization' }
BlGridOrientation class >> initialize [
	super initialize.
	
	HORIZONTAL := BlGridHorizontalOrientation new.
	VERTICAL := BlGridVerticalOrientation new.
]

{ #category : #factory }
BlGridOrientation class >> vertical [
	^ VERTICAL
]

{ #category : #comparing }
BlGridOrientation >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #testing }
BlGridOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
BlGridOrientation >> isVertical [
	^ false
]
