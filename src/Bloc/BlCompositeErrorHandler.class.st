Class {
	#name : #BlCompositeErrorHandler,
	#superclass : #BlErrorHandler,
	#instVars : [
		'errorHandlers'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #'instance creation' }
BlCompositeErrorHandler class >> withAll: aCollectionOfErrorHandlers [
	^ self new addErrorHandlers: aCollectionOfErrorHandlers
]

{ #category : #adding }
BlCompositeErrorHandler >> addErrorHandler: anErrorHandler [
	self errorHandlers add: anErrorHandler
]

{ #category : #adding }
BlCompositeErrorHandler >> addErrorHandlers: aCollectionOfErrorHandlers [
	self errorHandlers addAll: aCollectionOfErrorHandlers
]

{ #category : #accessing }
BlCompositeErrorHandler >> errorHandlers [
	<return: #Collection of: #BlErrorHandler>

	^ errorHandlers
]

{ #category : #initialization }
BlCompositeErrorHandler >> initialize [
	super initialize.
	
	errorHandlers := OrderedCollection new
]

{ #category : #testing }
BlCompositeErrorHandler >> matches: aFramePhase [
	^ self errorHandlers anySatisfy: [ :anErrorHandler | anErrorHandler matches: aFramePhase ]
]

{ #category : #running }
BlCompositeErrorHandler >> processError: anError in: anElement [
	self errorHandlers
		detect: [ :anErrorHandler | anElement isAttachedToSceneGraph and: [ anErrorHandler matches: anElement space frame currentPhase ] ]
		ifFound: [ :anErrorHandler | anErrorHandler handleError: anError in: anElement ]
		ifNone: [ self handleCriticalError: anError in: anElement ]
]
