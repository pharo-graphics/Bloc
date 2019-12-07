Class {
	#name : #BlDevScripterSelectorChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'selector'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #testing }
BlDevScripterSelectorChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isSymbol or: [ anObject isKindOf: BlockClosure ]
]

{ #category : #'instance creation' }
BlDevScripterSelectorChildEventTarget class >> newFromInput: anObject [
	^ self new selector: anObject
]

{ #category : #searching }
BlDevScripterSelectorChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

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
	<return: #Symbol>
	^ selector
]

{ #category : #accessing }
BlDevScripterSelectorChildEventTarget >> selector: aSymbol [
	selector := aSymbol
]
