"
I am the abstract superclass for singleton hosts.

A singleton host represents a system-wide display backend (such as headless, Morphic window, SDL2, SDL3) where only one shared instance is needed per Pharo session.
"
Class {
	#name : #BlSingletonHost,
	#superclass : #BlPulseLoopHost,
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #cleanup }
BlSingletonHost class >> cleanUp [
	default := nil
]

{ #category : #accessing }
BlSingletonHost class >> default [
	^ default ifNil: [ default := self basicNew initialize; yourself ]
]

{ #category : #testing }
BlSingletonHost class >> isSingleton [
	^ true
]

{ #category : #'instance creation' }
BlSingletonHost class >> new [
	self error: 'Use #default instead'
]
