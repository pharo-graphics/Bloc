Class {
	#name : #BlDevScripterBlockSelectorEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterBlockSelectorEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isKindOf: BlockClosure
]

{ #category : #'instance creation' }
BlDevScripterBlockSelectorEventTarget class >> newFromInput: anObject [
	^ self new block: anObject
]

{ #category : #accessing }
BlDevScripterBlockSelectorEventTarget >> block [
	<return: #BlockClosure>
	^ block
]

{ #category : #accessing }
BlDevScripterBlockSelectorEventTarget >> block: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isBlock and: [ anOneArgBlock argumentCount = 1 ] ] 
		description: [ 'Block selector must be one-argument block closure' ].
	block := anOneArgBlock
]

{ #category : #searching }
BlDevScripterBlockSelectorEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aChildren |
	aChildren := anElement children select: [ :eachChild | 
		[ self block value: eachChild ] on: Error do: [ :anException | false ] ].
	self assert: aChildren size equals: 1.
	^ aChildren first
]

{ #category : #accessing }
BlDevScripterBlockSelectorEventTarget >> identifier [
	^ self block ifNil: [ self ]
]

{ #category : #printing }
BlDevScripterBlockSelectorEventTarget >> printOn: aStream [
	self block ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Block Selector: ';
		print: self block.
]
