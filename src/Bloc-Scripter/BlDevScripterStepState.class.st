Class {
	#name : 'BlDevScripterStepState',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Scripter-Scripter-States',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-States'
}

{ #category : 'cleanup' }
BlDevScripterStepState class >> cleanUp [
	self resetUniqueInstance
	
]

{ #category : 'accessing' }
BlDevScripterStepState class >> default [
	^ self uniqueInstance
]

{ #category : 'accessing' }
BlDevScripterStepState class >> executing [
	^ BlDevScripterStepExecutingState default
]

{ #category : 'accessing' }
BlDevScripterStepState class >> failure [
	^ BlDevScripterStepFailureState default
]

{ #category : 'accessing' }
BlDevScripterStepState class >> haltHere [
	^ BlDevScripterStepHaltState default
]

{ #category : 'accessing' }
BlDevScripterStepState class >> ready [
	^ BlDevScripterStepReadyState default
]

{ #category : 'cleanup' }
BlDevScripterStepState class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlDevScripterStepState class >> success [
	^ BlDevScripterStepSuccessState default
]

{ #category : 'accessing' }
BlDevScripterStepState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
BlDevScripterStepState >> color [
	<return: #Color>
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlDevScripterStepState >> isHalt [
	^ false
]

{ #category : 'accessing' }
BlDevScripterStepState >> name [
	"Return the string representing the name of the receiver."
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlDevScripterStepState >> wasExecuted [
	
	^ false
]
