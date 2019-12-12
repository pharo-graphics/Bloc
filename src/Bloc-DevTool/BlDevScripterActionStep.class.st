Class {
	#name : #BlDevScripterActionStep,
	#superclass : #BlDevScripterTargetedStep,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterActionStep >> action: anOneArgBlock [
	self block: anOneArgBlock
]

{ #category : #asserting }
BlDevScripterActionStep >> assertBlock: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isNotNil ] 
		description: [ 'Block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs = 1 ] 
		description: [ 'Block must receive one argument' ].
]

{ #category : #accessing }
BlDevScripterActionStep >> block [
	^ block
]

{ #category : #accessing }
BlDevScripterActionStep >> block: anOneArgBlock [
	self assertBlock: anOneArgBlock.
	block := anOneArgBlock
]

{ #category : #accessing }
BlDevScripterActionStep >> defaultLabel [
	^ 'Model Interaction'
]

{ #category : #actions }
BlDevScripterActionStep >> playOn: aScripter [
	self assertBlock: self block.
	self block value: aScripter model.
]
