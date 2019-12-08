Class {
	#name : #BlDevScripterInteractionStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #initialization }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #accessing }
BlDevScripterInteractionStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #accessing }
BlDevScripterInteractionStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
