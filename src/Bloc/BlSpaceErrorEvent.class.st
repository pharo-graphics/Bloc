"
Is sent by space if there was an error during #pulse
"
Class {
	#name : #BlSpaceErrorEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'error'
	],
	#category : 'Bloc-Event'
}

{ #category : #'instance creation' }
BlSpaceErrorEvent class >> on: anError [
	^ self new error: anError
]

{ #category : #accessing }
BlSpaceErrorEvent >> error [
	^ error
]

{ #category : #accessing }
BlSpaceErrorEvent >> error: anObject [
	error := anObject
]
