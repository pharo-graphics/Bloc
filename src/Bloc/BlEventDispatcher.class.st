"
My subclasses are responsible of dispatching events.
"
Class {
	#name : #BlEventDispatcher,
	#superclass : #Object,
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #'api - event managing' }
BlEventDispatcher >> dispatchEvent: anEvent [

	^ self dispatchEvent: anEvent next: BlEventDispatcherChain empty
]

{ #category : #'api - event managing' }
BlEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [

	"Default implementation just dispaches to the next dispatcher in a chain"
	aBlEventDispatcherChain dispatchEvent: anEvent.

	^ anEvent
]

{ #category : #'api - accessing' }
BlEventDispatcher >> filters [

	^ Array streamContents: [ :aStream |
		  self filtersDo: [ :eachFilter | aStream nextPut: eachFilter ] ]
]

{ #category : #'api - accessing' }
BlEventDispatcher >> filtersDo: aBlock [
	"Evaulate a given block with every event filter as an argument"
	
	self subclassResponsibility
]

{ #category : #'api - accessing' }
BlEventDispatcher >> handlers [

	^ Array streamContents: [ :aStream |
		  self handlersDo: [ :eachHandler | aStream nextPut: eachHandler ] ]
]

{ #category : #'api - accessing' }
BlEventDispatcher >> handlersDo: aBlock [
	"Evaulate a given block with every event handler as an argument"
	
	self subclassResponsibility
]

{ #category : #'api - testing' }
BlEventDispatcher >> hasEventHandlerSuchThat: aBlock [

	self handlersDo: [ :eachHandler |
		(aBlock value: eachHandler) ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'api - event managing' }
BlEventDispatcher >> wantsEvent: anEvent [
	"Return true if my current conditions allow me to dispatch a given event, false otherwise.
	Default implementation always returns true. Override me to customize the behaviour"

	^ true
]
