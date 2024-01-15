Class {
	#name : #BlDevScripterCheckElementStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'block',
		'description'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
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

{ #category : #accessing }
BlDevScripterCheckElementStep >> description [
	^ description
]

{ #category : #accessing }
BlDevScripterCheckElementStep >> description: anObject [
	description := anObject
]

{ #category : #accessing }
BlDevScripterCheckElementStep >> initialize [
	super initialize.
	description := [ :aTarget | 
		'Step ', self label asString, 
		' is not satisfied: ', self block printString ].
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
		description: [ self description cull: anElement cull: aScripter userData ]
]
