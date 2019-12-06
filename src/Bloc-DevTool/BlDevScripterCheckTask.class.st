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
