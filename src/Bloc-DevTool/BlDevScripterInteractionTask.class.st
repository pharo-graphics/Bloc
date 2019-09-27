Class {
	#name : #BlDevScripterInteractionTask,
	#superclass : #BlDevScripterTask,
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #initialization }
BlDevScripterInteractionTask >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #target }
BlDevScripterInteractionTask >> onChildAt: aNumber [
	self target: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #target }
BlDevScripterInteractionTask >> onChildNamed: aSymbol [
	self target: (BlDevScripterNamedChildEventTarget new name: aSymbol)
]

{ #category : #target }
BlDevScripterInteractionTask >> onSelf [
	self target: (BlDevScripterSelfEventTarget new)
]

{ #category : #accessing }
BlDevScripterInteractionTask >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #accessing }
BlDevScripterInteractionTask >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
