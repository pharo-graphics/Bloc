"
A mutable Integer - used to avoid heap allocation during the layout operation

"
Class {
	#name : #BlGridMutableInteger,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'instance creation' }
BlGridMutableInteger class >> value: aNumber [
	^ self new value: aNumber
]

{ #category : #initialization }
BlGridMutableInteger >> initialize [
	super initialize.
	
	self reset
]

{ #category : #printing }
BlGridMutableInteger >> printOn: aStream [
	aStream nextPutAll: self value asString
]

{ #category : #accessing }
BlGridMutableInteger >> reset [
	value := UNDEFINED
]

{ #category : #evaluating }
BlGridMutableInteger >> value [
	^ 	value
]

{ #category : #accessing }
BlGridMutableInteger >> value: aNumber [
	value := aNumber
]
