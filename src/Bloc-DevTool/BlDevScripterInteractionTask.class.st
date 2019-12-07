Class {
	#name : #BlDevScripterInteractionTask,
	#superclass : #BlDevScripterTask,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
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

{ #category : #'as yet unclassified' }
BlDevScripterInteractionTask >> onChildSequence: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #accessing }
BlDevScripterInteractionTask >> onNestedChild: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #'as yet unclassified' }
BlDevScripterInteractionTask >> onNestedTarget: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
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
