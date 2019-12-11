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

{ #category : #initialization }
BlDevScripterTargetedStep >> defaultTarget [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target ifNil: [ target := self defaultTarget ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterTargetedStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]
