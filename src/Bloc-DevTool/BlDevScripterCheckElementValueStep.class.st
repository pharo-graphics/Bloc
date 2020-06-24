Class {
	#name : #BlDevScripterCheckElementValueStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'valueBlock',
		'equalsBlock'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> defaultLabel [
	^ self valueBlock 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> equalsBlock [
	^ equalsBlock
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> equalsBlock: anObject [
	equalsBlock := anObject
]

{ #category : #actions }
BlDevScripterCheckElementValueStep >> playOn: aScripter [
	| anElement |

	anElement := self target findTargetStartingInScripter: aScripter.
	self 
		assert: [ self valueBlock isNotNil ]
		description: [ 'Value block must be defined' ].
		
	self
		assert: (self valueBlock cull: anElement cull: aScripter userData)
		equals: (self equalsBlock value)
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> valueBlock [
	^ valueBlock
]

{ #category : #accessing }
BlDevScripterCheckElementValueStep >> valueBlock: anObject [
	valueBlock := anObject
]
