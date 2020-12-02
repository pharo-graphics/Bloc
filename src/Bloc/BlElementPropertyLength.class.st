Class {
	#name : #BlElementPropertyLength,
	#superclass : #Object,
	#instVars : [
		'value',
		'unit'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'instance creation' }
BlElementPropertyLength class >> em: aNumber [
	^ self new
		value: aNumber;
		unit: BlElementPropertyUnit em
]

{ #category : #'instance creation' }
BlElementPropertyLength class >> pt: aNumber [
	^ self new
		value: aNumber;
		unit: BlElementPropertyUnit pt
]

{ #category : #'instance creation' }
BlElementPropertyLength class >> rem: aNumber [
	^ self new
		value: aNumber;
		unit: BlElementPropertyUnit rem
]

{ #category : #initialization }
BlElementPropertyLength >> initialize [
	super initialize.
	
	value := 0.
	unit := BlElementPropertyUnit pt.
]

{ #category : #printing }
BlElementPropertyLength >> printOn: aStream [
	aStream
		print: self value;
		print: self unit
]

{ #category : #accessing }
BlElementPropertyLength >> unit [
	^ unit
]

{ #category : #accessing }
BlElementPropertyLength >> unit: anObject [
	unit := anObject
]

{ #category : #accessing }
BlElementPropertyLength >> value [
	^ value
]

{ #category : #accessing }
BlElementPropertyLength >> value: anObject [
	value := anObject
]
