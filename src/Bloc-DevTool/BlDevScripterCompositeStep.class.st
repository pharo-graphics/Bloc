Class {
	#name : #BlDevScripterCompositeStep,
	#superclass : #BlDevScripterStep,
	#traits : 'TBlDevScripterCompositeStepTarget',
	#classTraits : 'TBlDevScripterCompositeStepTarget classTrait',
	#instVars : [
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

{ #category : #actions }
BlDevScripterCompositeStep >> playOn: aScripter [
	self steps do: [ :eachTask | eachTask playIndicatingStateOn: aScripter ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> previousTarget [
	<return: #BlDevScripterEventTarget>
	self 
		assert: [ self steps size > 1 ]
		description: [ 'Two steps must be defined before accessing previous target' ].
	^ (self steps at: self steps size - 1) target
]

{ #category : #accessing }
BlDevScripterCompositeStep >> steps [
	^ steps
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> target [
	"We access the target of the last sub-step.
	It simplifies API as we can send a target definition message to me. 
	We can write: 
		aStep
			elementSatisfies: [ :anElement | anElement text asString = 'feenk' ];
			onElementOfClass: BlTextElement.
	Instead of 
		(aStep elementSatisfies: [ :anElement | anElement text asString = 'feenk' ])
			onElementOfClass: BlTextElement."
	<return: #BlDevScripterEventTarget>
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'One step must be defined before accessing its target' ].
	^ self steps last target
]

{ #category : #'targets - accessing and updating' }
BlDevScripterCompositeStep >> target: aScripterEventTarget [
	"We access the target of the last sub-step.
	See #target message for the detailed explanation."
	self 
		assert: [ self steps isNotEmpty ]
		description: [ 'One step must be defined before defining its target' ].
	self steps last target: aScripterEventTarget
]
