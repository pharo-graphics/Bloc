Class {
	#name : #BlDevScripterInteractionStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #'targets - accessing and updating' }
BlDevScripterInteractionStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterInteractionStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
