Class {
	#name : #BlDevScripterCheckDoStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'block'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckDoStep >> block [
	<return: #BlockClosure>
	^ block
]

{ #category : #accessing }
BlDevScripterCheckDoStep >> block: anObject [
	block := anObject
]

{ #category : #accessing }
BlDevScripterCheckDoStep >> defaultLabel [
	^ self block 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterCheckDoStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetStartingInScripter: aScripter.
	self 
		assert: self block isNotNil
		description: 'Check block must be defined'.
	self block cull: anElement cull: aScripter userData.
]
