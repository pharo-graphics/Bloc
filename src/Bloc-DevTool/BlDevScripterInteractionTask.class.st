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

{ #category : #accessing }
BlDevScripterInteractionTask >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #accessing }
BlDevScripterInteractionTask >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
