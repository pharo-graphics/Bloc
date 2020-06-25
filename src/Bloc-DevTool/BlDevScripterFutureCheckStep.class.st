Class {
	#name : #BlDevScripterFutureCheckStep,
	#superclass : #BlDevScripterCheckStep,
	#traits : 'TBlDevScripterCheckStep + TBlDevScripterCheckStepCreation + TBlDevScripterCompositeStepTarget',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait + TBlDevScripterCompositeStepTarget classTrait',
	#instVars : [
		'parent',
		'hasCustomTarget',
		'realStep'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #adding }
BlDevScripterFutureCheckStep >> addStep: aScripterTask [
	<return: #BlDevScripterStep>
	self hasCustomLabel ifTrue: [ aScripterTask label: self label ].
	self hasCustomTarget ifTrue: [ aScripterTask target: self target ].
	self realStep: aScripterTask.
	^ self parent addStep: aScripterTask.
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> hasCustomTarget [
	<return: #Boolean>
	^ hasCustomTarget
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> hasRealStep [
	<return: #Boolean>
	^ realStep isNotNil
]

{ #category : #initialization }
BlDevScripterFutureCheckStep >> initialize [
	super initialize.
	hasCustomTarget := false.
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> label: anObject [
	self hasRealStep
		ifFalse: [ super label: anObject ]
		ifTrue: [ self realStep label: anObject ]
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> parent [
	^ parent
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> parent: anObject [
	parent := anObject
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> previousTarget [
	<return: #BlDevScripterEventTarget>
	^ self parent previousTarget
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> realStep [
	<return: #BlDevScripterStep>
	^ realStep
]

{ #category : #accessing }
BlDevScripterFutureCheckStep >> realStep: aScripterTask [
	realStep := aScripterTask
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> target: aScripterEventTarget [
	self hasRealStep
		ifFalse: [ 
			super target: aScripterEventTarget.
			hasCustomTarget := true ]
		ifTrue: [ 
			self realStep target: aScripterEventTarget ]
]

{ #category : #'targets - accessing and updating' }
BlDevScripterFutureCheckStep >> updateTarget: aScripterEventTarget [
	self hasRealStep 
		ifFalse: [ super updateTarget: aScripterEventTarget ]
		ifTrue: [ self realStep updateTarget: aScripterEventTarget ]
]
