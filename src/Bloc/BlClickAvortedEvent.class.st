Class {
	#name : #BlClickAvortedEvent,
	#superclass : #BlMouseEvent,
	#instVars : [
		'processor',
		'upTarget'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlClickAvortedEvent >> processor [

	^ processor
]

{ #category : #accessing }
BlClickAvortedEvent >> processor: aMouseProcessor [

	processor := aMouseProcessor
]

{ #category : #sending }
BlClickAvortedEvent >> sendTo: anObject [
	anObject clickAvortedEvent: self
]

{ #category : #accessing }
BlClickAvortedEvent >> upTarget [

	^ upTarget
]

{ #category : #accessing }
BlClickAvortedEvent >> upTarget: anElement [

	upTarget := anElement
]
