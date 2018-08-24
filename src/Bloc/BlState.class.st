"
My subclasses represent the interaction states basically available for a graphics object. 
"
Class {
	#name : #BlState,
	#superclass : #Object,
	#category : 'Bloc-State'
}

{ #category : #comparing }
BlState class >> <= aStateClass [
	^ self priority <= aStateClass priority
]

{ #category : #comparing }
BlState class >> >= aStateClass [
	^ self priority >= aStateClass priority
]

{ #category : #converting }
BlState class >> asSymbol [
	^ self shouldBeImplemented
]

{ #category : #converting }
BlState class >> fromSymbol: aSymbol [
	self
		subclassesDo: [ :aClass | 
			aClass asSymbol = aSymbol
				ifTrue: [ ^ aClass ] ]
]

{ #category : #comparing }
BlState class >> priority [
	self subclassResponsibility
]
