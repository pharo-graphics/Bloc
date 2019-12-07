Class {
	#name : #BlDevScripterCheckTask,
	#superclass : #BlDevScripterTask,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #initialization }
BlDevScripterCheckTask >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #accessing }
BlDevScripterCheckTask >> label [
	^ 'Check'
]

{ #category : #'as yet unclassified' }
BlDevScripterCheckTask >> onChildSequence: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #accessing }
BlDevScripterCheckTask >> onNestedChild: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #'as yet unclassified' }
BlDevScripterCheckTask >> onNestedTarget: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #actions }
BlDevScripterCheckTask >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetIn: aScripter element.
	self validateOn: anElement
]

{ #category : #accessing }
BlDevScripterCheckTask >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #accessing }
BlDevScripterCheckTask >> target: aScripterEventTarget [
	target := aScripterEventTarget
]

{ #category : #actions }
BlDevScripterCheckTask >> validateOn: anElement [
	"validate targeted element"
]
