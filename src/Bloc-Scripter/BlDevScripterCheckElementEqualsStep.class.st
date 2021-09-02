Class {
	#name : 'BlDevScripterCheckElementEqualsStep',
	#superclass : 'BlDevScripterCheckStep',
	#instVars : [
		'equalsBlock'
	],
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterCheckElementEqualsStep >> defaultLabel [
	^ self equalsBlock 
		ifNotNil: [ :aBlock | aBlock printStringLimitedTo: 42 ] 
		ifNil: [ self className ]
]

{ #category : 'accessing' }
BlDevScripterCheckElementEqualsStep >> equalsBlock [
	^ equalsBlock
]

{ #category : 'accessing' }
BlDevScripterCheckElementEqualsStep >> equalsBlock: anObject [
	equalsBlock := anObject
]

{ #category : 'actions' }
BlDevScripterCheckElementEqualsStep >> playOn: aScripter [
	| anElement |

	anElement := self target findTargetStartingInScripter: aScripter.
	self 
		assert: [ self equalsBlock notNil ]
		description: [ 'Equals block must be defined' ].
		
	self
		assert: anElement
		equals: (self equalsBlock isClosure
			ifTrue: [ self equalsBlock cull: anElement cull: aScripter userData ]
			ifFalse: [ self equalsBlock value ] )
]
