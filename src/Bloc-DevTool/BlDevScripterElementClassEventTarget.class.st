Class {
	#name : #BlDevScripterElementClassEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'elementClass'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterElementClassEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isClass
]

{ #category : #'instance creation' }
BlDevScripterElementClassEventTarget class >> newFromInput: anObject [
	^ self new elementClass: anObject
]

{ #category : #accessing }
BlDevScripterElementClassEventTarget >> elementClass [
	<return: #Class>
	^ elementClass
]

{ #category : #accessing }
BlDevScripterElementClassEventTarget >> elementClass: aClass [
	self 
		assert: [ aClass isNotNil and: [ (self class environment at: aClass name) = aClass ] ] 
		description: [ 'Element class must be defined in the environment' ].
	self 
		assert: [ aClass == BlElement or: [ 
			aClass inheritsFrom: BlElement ] ]
		description: [ 'Element class must be subclass of BlElement' ].
	elementClass := aClass
]

{ #category : #searching }
BlDevScripterElementClassEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	| aChildren |
	aChildren := anElement children select: [ :eachChild | eachChild class = self elementClass ].
	self assert: aChildren size equals: 1.
	^ aChildren first
]

{ #category : #accessing }
BlDevScripterElementClassEventTarget >> identifier [
	^ self elementClass ifNil: [ self ]
]

{ #category : #printing }
BlDevScripterElementClassEventTarget >> printOn: aStream [
	self elementClass ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child Class: ';
		print: self elementClass.
]
