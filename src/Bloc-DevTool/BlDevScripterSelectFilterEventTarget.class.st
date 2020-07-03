Class {
	#name : #BlDevScripterSelectFilterEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterSelectFilterEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isKindOf: BlockClosure
]

{ #category : #'instance creation' }
BlDevScripterSelectFilterEventTarget class >> newFromInput: anObject [
	^ self new block: anObject
]

{ #category : #accessing }
BlDevScripterSelectFilterEventTarget >> block [
	<return: #BlockClosure>
	^ block
]

{ #category : #accessing }
BlDevScripterSelectFilterEventTarget >> block: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isBlock and: [ anOneArgBlock argumentCount = 1 ] ] 
		description: [ 'Block selector must be one-argument block closure' ].
	block := anOneArgBlock
]

{ #category : #searching }
BlDevScripterSelectFilterEventTarget >> findTargetIn: aCollection [
	<return: #BlElement>

	^ aCollection select: self block
]

{ #category : #accessing }
BlDevScripterSelectFilterEventTarget >> identifier [
	^ self block ifNil: [ self ]
]

{ #category : #printing }
BlDevScripterSelectFilterEventTarget >> printOn: aStream [
	self block ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'select: ';
		print: self block.
]
