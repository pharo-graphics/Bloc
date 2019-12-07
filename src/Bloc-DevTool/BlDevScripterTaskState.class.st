Class {
	#name : #BlDevScripterTaskState,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #cleanup }
BlDevScripterTaskState class >> cleanUp [
	self resetUniqueInstance
	
]

{ #category : #accessing }
BlDevScripterTaskState class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
BlDevScripterTaskState class >> executing [
	^ BlDevScripterTaskExecutingState default
]

{ #category : #accessing }
BlDevScripterTaskState class >> failure [
	^ BlDevScripterTaskFailureState default
]

{ #category : #accessing }
BlDevScripterTaskState class >> ready [
	^ BlDevScripterTaskReadyState default
]

{ #category : #cleanup }
BlDevScripterTaskState class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
BlDevScripterTaskState class >> success [
	^ BlDevScripterTaskSuccessState default
]

{ #category : #accessing }
BlDevScripterTaskState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlDevScripterTaskState >> color [
	^ self subclassResponsibility
]
