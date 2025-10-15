"
I am a special event handler that increases `counter` every time I handle an event

"
Class {
	#name : #BlExampleLoggingEventHandler,
	#superclass : #BlEventHandler,
	#instVars : [
		'counter'
	],
	#category : #'Bloc-UnitedTests-Handler'
}

{ #category : #'instance creation' }
BlExampleLoggingEventHandler class >> on: anEventClass [
	^ self new eventClass: anEventClass
]

{ #category : #accessing }
BlExampleLoggingEventHandler >> counter [
	^ counter
]

{ #category : #accessing }
BlExampleLoggingEventHandler >> counter: anObject [
	counter := anObject
]

{ #category : #initialization }
BlExampleLoggingEventHandler >> initialize [
	super initialize.
	
	counter := 0.
	self action: [ counter := counter + 1 ]
]
