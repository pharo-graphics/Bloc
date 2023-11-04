Class {
	#name : 'BlClickAvortedEvent',
	#superclass : 'BlMouseEvent',
	#instVars : [
		'processor',
		'upEvent'
	],
	#category : 'Bloc-Events'
}

{ #category : 'accessing' }
BlClickAvortedEvent >> processor [

	^ processor
]

{ #category : 'accessing' }
BlClickAvortedEvent >> processor: aMouseProcessor [

	processor := aMouseProcessor
]

{ #category : 'sending' }
BlClickAvortedEvent >> sendTo: anObject [
	anObject clickAvortedEvent: self
]

{ #category : 'accessing' }
BlClickAvortedEvent >> upEvent [

	^ upEvent
]

{ #category : 'accessing' }
BlClickAvortedEvent >> upEvent: anElement [

	upEvent := anElement
]
