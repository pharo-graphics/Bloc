Class {
	#name : #BlDevScripterTargetedStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
