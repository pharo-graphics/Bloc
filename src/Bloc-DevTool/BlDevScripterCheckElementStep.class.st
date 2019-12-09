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
BlDevScripterCheckElementStep >> label [
	^ self block 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterCheckElementStep >> validateOn: anElement [
	self 
		assert: self block isNotNil
		description: 'Check block must be defined'.
	self 
		assert: (self block value: anElement)
		description: [ 'Element does not satisfy ', self block printString ]
]
