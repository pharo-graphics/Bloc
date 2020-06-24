Class {
	#name : #BlDevScripterCheckElementStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckElementStep >> block [
	<return: #BlockClosure>
	^ block
]

{ #category : #accessing }
BlDevScripterCheckElementStep >> block: anObject [
	block := anObject
]

{ #category : #accessing }
BlDevScripterCheckElementStep >> defaultLabel [
	^ self block 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterCheckElementStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetStartingInScripter: aScripter.
	self 
		assert: [ self block isNotNil ]
		description: [ 'Check block must be defined' ].
	self 
		assert: [ self block cull: anElement cull: aScripter userData ]
		description: [ 'It does not satisfy ', self block printString ]
]
