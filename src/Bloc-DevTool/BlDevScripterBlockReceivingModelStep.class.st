Class {
	#name : #BlDevScripterBlockReceivingModelStep,
	#superclass : #BlDevScripterModelStep,
	#instVars : [
		'block'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #asserting }
BlDevScripterBlockReceivingModelStep >> assertBlock: anOneArgBlock [
	self 
		assert: [ anOneArgBlock isNotNil ] 
		description: [ 'Block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs = 1 ] 
		description: [ 'Block must receive one argument' ].
]

{ #category : #accessing }
BlDevScripterBlockReceivingModelStep >> block [
	^ block
]

{ #category : #accessing }
BlDevScripterBlockReceivingModelStep >> block: anOneArgBlock [
	self assertBlock: anOneArgBlock.
	block := anOneArgBlock
]

{ #category : #accessing }
BlDevScripterBlockReceivingModelStep >> do: anOneArgBlock [
	self block: anOneArgBlock
]

{ #category : #actions }
BlDevScripterBlockReceivingModelStep >> playOn: aScripter [
	self assertBlock: self block.
	self block value: aScripter model.
]
