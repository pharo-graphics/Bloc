Class {
	#name : #BlDevScripterNoReference,
	#superclass : #BlDevScripterReference,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-DevTool-Scripter-References'
}

{ #category : #cleanup }
BlDevScripterNoReference class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
BlDevScripterNoReference class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
BlDevScripterNoReference class >> uniqueInstance [ 
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
