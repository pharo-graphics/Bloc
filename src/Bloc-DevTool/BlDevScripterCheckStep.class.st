Class {
	#name : #BlDevScripterCheckStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckStep >> defaultLabel [
	^ 'Check'
]

{ #category : #initialization }
BlDevScripterCheckStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #actions }
BlDevScripterCheckStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetIn: aScripter element.
	self validateOn: anElement
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCheckStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCheckStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]

{ #category : #actions }
BlDevScripterCheckStep >> validateOn: anElement [
	"validate targeted element"
]
