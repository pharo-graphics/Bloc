Class {
	#name : #BlDevScripterCheckStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #initialization }
BlDevScripterCheckStep >> initialize [
	super initialize.
	
	self onSelf
]

{ #category : #accessing }
BlDevScripterCheckStep >> label [
	^ 'Check'
]

{ #category : #actions }
BlDevScripterCheckStep >> playOn: aScripter [
	| anElement |
	anElement := self target findTargetIn: aScripter element.
	self validateOn: anElement
]

{ #category : #accessing }
BlDevScripterCheckStep >> target [
	<return: #BlDevScripterEventTarget>

	^ target
]

{ #category : #accessing }
BlDevScripterCheckStep >> target: aScripterEventTarget [
	target := aScripterEventTarget
]

{ #category : #actions }
BlDevScripterCheckStep >> validateOn: anElement [
	"validate targeted element"
]
