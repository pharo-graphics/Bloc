Class {
	#name : #BlDevScripterSelectorChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'selector'
	],
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterSelectorChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isSymbol
]

{ #category : #'instance creation' }
BlDevScripterSelectorChildEventTarget class >> newFromInput: anObject [
	^ self new selector: anObject
]

{ #category : #searching }
BlDevScripterSelectorChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	self assert: self selector isNotNil.
	(anElement respondsTo: self selector) ifFalse: [ 
		AssertionFailure signal: anElement printString, ' does not responds to ', self selector asString ].
	^ self selector cull: anElement
]

{ #category : #accessing }
BlDevScripterSelectorChildEventTarget >> identifier [
	^ self selector
]

{ #category : #printing }
BlDevScripterSelectorChildEventTarget >> printOn: aStream [
	self selector ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child Selector: ';
		print: self selector.
]

{ #category : #accessing }
BlDevScripterSelectorChildEventTarget >> selector [
	
	^ selector
]

{ #category : #accessing }
BlDevScripterSelectorChildEventTarget >> selector: aSymbol [
	self 
		assert: [ aSymbol isSymbol and: [ aSymbol isNotEmpty ] ]
		description: [ 'Selector must be a non-empty symbol' ].
	self 
		assert: [ aSymbol numArgs = 0 ]
		description: [ 'Selector must be an unnary message' ].
	selector := aSymbol
]
