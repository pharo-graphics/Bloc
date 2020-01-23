Class {
	#name : #BlAsyncNoPreviewStrategy,
	#superclass : #BlAsyncPreviewStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Async'
}

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
BlAsyncNoPreviewStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #scheduling }
BlAsyncNoPreviewStrategy >> schedulePreviewIn: anElement [
	"do nothing"
	
]
