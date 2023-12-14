Class {
	#name : 'BlDevScripterActionStep',
	#superclass : 'BlDevScripterTargetedStep',
	#instVars : [
		'block'
	],
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterActionStep >> action: anOneArgBlock [
	self block: anOneArgBlock
]

{ #category : 'asserting' }
BlDevScripterActionStep >> assertBlock: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isNotNil ] 
		description: [ 'Block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs < 4 ] 
		description: [ 'Block must receive less then 4 arguments' ].
]

{ #category : 'accessing' }
BlDevScripterActionStep >> block [
	^ block
]

{ #category : 'accessing' }
BlDevScripterActionStep >> block: anOneArgBlock [
	self assertBlock: anOneArgBlock.
	block := anOneArgBlock
]

{ #category : 'accessing' }
BlDevScripterActionStep >> defaultLabel [
	^ 'Action'
]

{ #category : 'actions' }
BlDevScripterActionStep >> playOn: aScripter [
	| aTarget |
	self assertBlock: self block.
	aTarget := self target findTargetStartingInScripter: aScripter.
	self block cull: aTarget cull: aScripter userData cull: aScripter.
]

{ #category : 'accessing' }
BlDevScripterActionStep >> pulse [
	self label: 'Pulse space'.
	self onSpace.
	self block: [ :aSpace | aSpace pulse ].
]
