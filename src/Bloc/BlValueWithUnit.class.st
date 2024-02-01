"
# Value with unit

Represents a `dimensioned quantity` or `dimensioned number`, for example `10pt` or `30%`.
The {{gtMethod:BlValueWithUnit>>#value|label=value}} can be any object, but in most cases it is a number, the {{gtMethod:BlValueWithUnit>>#unit|label=unit}} is an instance of a concrete subclass of {{gtClass:BlUnit}}

"
Class {
	#name : #BlValueWithUnit,
	#superclass : #Object,
	#instVars : [
		'value',
		'unit'
	],
	#category : 'Bloc-Basic-Units'
}

{ #category : #'instance creation' }
BlValueWithUnit class >> em: aNumber [
	^ self new
		value: aNumber;
		unit: BlUnit em
]

{ #category : #'instance creation' }
BlValueWithUnit class >> percent: aNumber [
	^ self new
		value: aNumber;
		unit: BlUnit percent
]

{ #category : #'instance creation' }
BlValueWithUnit class >> pt: aNumber [
	^ self new
		value: aNumber;
		unit: BlUnit pt
]

{ #category : #'instance creation' }
BlValueWithUnit class >> rem: aNumber [
	^ self new
		value: aNumber;
		unit: BlUnit rem
]

{ #category : #comparing }
BlValueWithUnit >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value and: [ unit = anObject unit ]
]

{ #category : #comparing }
BlValueWithUnit >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash bitXor: unit hash
]

{ #category : #initialization }
BlValueWithUnit >> initialize [
	super initialize.
	
	value := 0.
	unit := BlUnit pt.
]

{ #category : #printing }
BlValueWithUnit >> printOn: aStream [
	aStream
		print: self value;
		print: self unit
]

{ #category : #accessing }
BlValueWithUnit >> unit [
	<return: #BlUnit>

	^ unit
]

{ #category : #accessing }
BlValueWithUnit >> unit: aBlUnit [
	unit := aBlUnit
]

{ #category : #accessing }
BlValueWithUnit >> value [
	^ value
]

{ #category : #accessing }
BlValueWithUnit >> value: anObject [
	value := anObject
]
