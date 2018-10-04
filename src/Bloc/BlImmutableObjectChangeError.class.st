Class {
	#name : #BlImmutableObjectChangeError,
	#superclass : #Error,
	#instVars : [
		'object'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #accessing }
BlImmutableObjectChangeError class >> object: anObject [
	^ self new object: anObject
]

{ #category : #accessing }
BlImmutableObjectChangeError >> description [
	^ self object printString, ' is immutable and can not be changed'
]

{ #category : #accessing }
BlImmutableObjectChangeError >> object [
	^ object
]

{ #category : #accessing }
BlImmutableObjectChangeError >> object: anObject [
	object := anObject
]
