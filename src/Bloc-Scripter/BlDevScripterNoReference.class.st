Class {
	#name : 'BlDevScripterNoReference',
	#superclass : 'BlDevScripterReference',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Scripter-Scripter-Properties',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Properties'
}

{ #category : 'cleanup' }
BlDevScripterNoReference class >> cleanUp [
	self resetUniqueInstance
]

{ #category : 'cleanup' }
BlDevScripterNoReference class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlDevScripterNoReference class >> uniqueInstance [ 
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
