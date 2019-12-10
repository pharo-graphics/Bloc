Class {
	#name : #BlDevScripterNamedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'name'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterNamedChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isString and: [ anObject isSymbol not ]
]

{ #category : #'instance creation' }
BlDevScripterNamedChildEventTarget class >> newFromInput: anObject [
	^ self new name: anObject
]

{ #category : #searching }
BlDevScripterNamedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ anElement 
		childNamed: self name
		ifFound: [ :theChild | theChild ]
		ifNone: [ AssertionFailure signal: 'Children container named ', self name asString, ' does not exist' ]
]

{ #category : #accessing }
BlDevScripterNamedChildEventTarget >> identifier [
	^ self name
]

{ #category : #accessing }
BlDevScripterNamedChildEventTarget >> name [
	^ name
]

{ #category : #accessing }
BlDevScripterNamedChildEventTarget >> name: anObject [
	name := anObject
]

{ #category : #printing }
BlDevScripterNamedChildEventTarget >> printOn: aStream [
	self name ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child Named: ';
		print: self name.
]
