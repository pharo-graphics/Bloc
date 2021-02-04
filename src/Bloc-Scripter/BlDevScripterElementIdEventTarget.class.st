Class {
	#name : #BlDevScripterElementIdEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'elementId'
	],
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterElementIdEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isString and: [ anObject isSymbol not ]
]

{ #category : #'instance creation' }
BlDevScripterElementIdEventTarget class >> newFromInput: anObject [
	^ self new name: anObject
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> elementId [
	<return: #BlElementId>

	^ elementId
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> elementId: aBlElementId [
	elementId := aBlElementId asBlocElementId
]

{ #category : #searching }
BlDevScripterElementIdEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ anElement 
		childWithId: self elementId
		ifFound: [ :theChild | theChild ]
		ifNone: [ AssertionFailure signal: 'Element with id ', self elementId asSymbol, ' does not exist' ]
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> identifier [
	^ self elementId asSymbol
]

{ #category : #printing }
BlDevScripterElementIdEventTarget >> printOn: aStream [
	self elementId ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Element id: ';
		print: self identifier
]
