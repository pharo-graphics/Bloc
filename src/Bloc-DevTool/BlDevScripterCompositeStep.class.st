Class {
	#name : #BlDevScripterCompositeStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'label',
		'steps'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #adding }
BlDevScripterCompositeStep >> addStep: aStep [
	steps add: aStep.
	^ aStep
]

{ #category : #actions }
BlDevScripterCompositeStep >> continueOn: aScripter [
	self wasExecuted 
		ifTrue: [ self steps do: [ :eachTask | eachTask continueOn: aScripter ] ]
		ifFalse: [ self playIndicatingStateOn: aScripter ].
]

{ #category : #accessing }
BlDevScripterCompositeStep >> defaultLabel [
	^ 'Steps'
]

{ #category : #initialization }
BlDevScripterCompositeStep >> initialize [
	super initialize.
	
	steps := OrderedCollection new
]

{ #category : #accessing }
BlDevScripterCompositeStep >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlDevScripterCompositeStep >> label: anObject [
	label := anObject
]

{ #category : #actions }
BlDevScripterCompositeStep >> playOn: aScripter [
	self steps do: [ :eachTask | eachTask playIndicatingStateOn: aScripter ]
]

{ #category : #accessing }
BlDevScripterCompositeStep >> steps [
	^ steps
]

{ #category : #accessing }
BlDevScripterCompositeStep >> target [
	<return: #BlDevScripterEventTarget>
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'A subtask must be defined before accessing target' ].
	^ self steps last target
]

{ #category : #accessing }
BlDevScripterCompositeStep >> target: aScripterEventTarget [
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'A subtask must be defined before defining target' ].
	self steps last target: aScripterEventTarget
]
