Class {
	#name : #BlDevScripterCheckElementTask,
	#superclass : #BlDevScripterCheckTask,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterCheckElementTask >> block [
	<return: #BlockClosure>
	^ block
]

{ #category : #accessing }
BlDevScripterCheckElementTask >> block: anObject [
	block := anObject
]

{ #category : #accessing }
BlDevScripterCheckElementTask >> label [
	^ self block 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterCheckElementTask >> validateOn: anElement [
	self 
		assert: self block isNotNil
		description: 'Check block must be defined'.
	self 
		assert: (self block value: anElement)
		description: [ 'Element does not satisfy ', self block printString ]
]
