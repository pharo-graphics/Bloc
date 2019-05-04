"
I represent an error that bloc gracefully handled during some specific frame phase
"
Class {
	#name : #BlHandledError,
	#superclass : #Object,
	#instVars : [
		'error',
		'errorHandler',
		'framePhase',
		'element'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #accessing }
BlHandledError >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlHandledError >> element: anElement [
	element := anElement
]

{ #category : #accessing }
BlHandledError >> error [
	^ error
]

{ #category : #accessing }
BlHandledError >> error: anError [
	error := anError
]

{ #category : #accessing }
BlHandledError >> errorHandler [
	^ errorHandler
]

{ #category : #accessing }
BlHandledError >> errorHandler: anObject [
	errorHandler := anObject
]

{ #category : #accessing }
BlHandledError >> framePhase [
	<return: #BlSpaceFramePhase>

	^ framePhase
]

{ #category : #accessing }
BlHandledError >> framePhase: aSpaceFramePhase [
	framePhase := aSpaceFramePhase
]
