Class {
	#name : 'BlDevScripterTextAttributesAtTarget',
	#superclass : 'BlDevScripterEventTarget',
	#instVars : [
		'index'
	],
	#category : 'Bloc-Scripter-Scripter-Targets',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterTextAttributesAtTarget >> findTargetIn: aText [
	<return: #BlElement>

	self assert: self index isInteger.
	(aText respondsTo: #attributesAt:) ifFalse: [ 
		AssertionFailure signal: aText printString, ' does not responds to ', #attributesAt: asString ].
	^ aText attributesAt: self index
]

{ #category : 'accessing' }
BlDevScripterTextAttributesAtTarget >> identifier [
	^ self index
]

{ #category : 'accessing' }
BlDevScripterTextAttributesAtTarget >> index [
	<return: #Number>
	^ index
]

{ #category : 'accessing' }
BlDevScripterTextAttributesAtTarget >> index: aNumber [
	self 
		assert: [ aNumber isInteger ]
		description: [ 'Index must be an integer' ].
	self 
		assert: [ aNumber >= 0 ]
		description: [ 'Index must be positive number' ].
	index := aNumber
]

{ #category : 'printing' }
BlDevScripterTextAttributesAtTarget >> printOn: aStream [
	self index ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Text Attributes At: ';
		print: self index.
]
