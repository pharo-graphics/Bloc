Class {
	#name : #BlAsyncElementUpdateStrategy,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Async'
}

{ #category : #cleanup }
BlAsyncElementUpdateStrategy class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
BlAsyncElementUpdateStrategy class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
BlAsyncElementUpdateStrategy class >> default [
	^ self uniqueInstance
]

{ #category : #factory }
BlAsyncElementUpdateStrategy class >> never [
	^ BlUpdateNeverUpdateStrategy default 
]

{ #category : #accessing }
BlAsyncElementUpdateStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #factory }
BlAsyncElementUpdateStrategy class >> whenInScene [
	^ BlUpdateWhenInSceneStrategy default 
]

{ #category : #factory }
BlAsyncElementUpdateStrategy class >> whenVisible [
	^ BlUpdateWhenVisibleStrategy default 
]

{ #category : #testing }
BlAsyncElementUpdateStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ self subclassResponsibility
]
