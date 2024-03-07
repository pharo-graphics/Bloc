Class {
	#name : #BlClickAbortedEvent,
	#superclass : #BlMouseEvent,
	#instVars : [
		'processor',
		'upEvent'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlClickAbortedEvent >> processor [

	^ processor
]

{ #category : #accessing }
BlClickAbortedEvent >> processor: aMouseProcessor [

	processor := aMouseProcessor
]

{ #category : #sending }
BlClickAbortedEvent >> sendTo: anObject [
	anObject clickAbortedEvent: self
]

{ #category : #accessing }
BlClickAbortedEvent >> upEvent [

	^ upEvent
]

{ #category : #accessing }
BlClickAbortedEvent >> upEvent: anElement [

	upEvent := anElement
]
