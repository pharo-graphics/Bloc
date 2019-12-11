Class {
	#name : #BlDevScripterModelStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterModelStep >> defaultLabel [
	^ 'Model Interaction'
]

{ #category : #accessing }
BlDevScripterModelStep >> target [
	^ target ifNil: [ target := BlDevScripterModelTarget new ]
]
