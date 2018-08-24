Class {
	#name : #BlStyleEventListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'styleable'
	],
	#category : 'Bloc-Style-EventListener'
}

{ #category : #'as yet unclassified' }
BlStyleEventListener >> applyStyles [
	styleable styler apply.
	styleable invalidate.
]

{ #category : #'as yet unclassified' }
BlStyleEventListener >> computeStyles [
	styleable stylesheets computeStyleNodes.
	self applyStyles
]

{ #category : #'as yet unclassified' }
BlStyleEventListener >> elementAddedEvent: anEvent [
	self computeStyles
]

{ #category : #'as yet unclassified' }
BlStyleEventListener >> elementRemovedEvent: anEvent [
	"self computeStyles"
]

{ #category : #'as yet unclassified' }
BlStyleEventListener >> elementStateChangedEvent: anEvent [
	self applyStyles
]

{ #category : #'as yet unclassified' }
BlStyleEventListener >> onInstalledIn: aStyleable [
	styleable := aStyleable.
	super onInstalledIn: aStyleable.
	"self computeStyles"
]
