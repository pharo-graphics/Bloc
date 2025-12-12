Class {
	#name : #BlDevScripterElementIdEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'elementId',
		'index'
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
	| aCounter |

	aCounter := 0.
	anElement allChildrenBreadthFirstDo: [ :aChild |
		aChild elementId = elementId
			ifTrue: [
				aCounter := aCounter + 1.
				aCounter = index
					ifTrue: [ ^ aChild ] ] ].

	AssertionFailure signal: index asString, 'th element with id ', self elementId asSymbol
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> identifier [
	^ self elementId asSymbol
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> index [
	^ index
]

{ #category : #accessing }
BlDevScripterElementIdEventTarget >> index: anObject [
	index := anObject
]

{ #category : #initialization }
BlDevScripterElementIdEventTarget >> initialize [
	super initialize.
	
	index := 1
]

{ #category : #printing }
BlDevScripterElementIdEventTarget >> printOn: aStream [
	self elementId ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Element id: ';
		print: self identifier
]
