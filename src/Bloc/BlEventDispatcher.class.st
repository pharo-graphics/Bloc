Class {
	#name : #BlEventDispatcher,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Events-Dispatcher'
}

{ #category : 'api - event managing' }
BlEventDispatcher >> dispatchEvent: anEvent [
	<return: #BlEvent>

	^ self dispatchEvent: anEvent next: BlEventDispatcherChain empty
]

{ #category : 'api - event managing' }
BlEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [
	<return: #BlEvent>

	"Default implementation just dispaches to the next dispatcher in a chain"
	aBlEventDispatcherChain dispatchEvent: anEvent.

	^ anEvent
]

{ #category : 'api - accessing' }
BlEventDispatcher >> filters [
	^ Array streamContents: [ :aStream | self filtersDo: [ :eachFilter | aStream nextPut: eachFilter ] ]
]

{ #category : 'api - accessing' }
BlEventDispatcher >> filtersDo: aBlock [
	"Evaulate a given block with every event filter as an argument"
]

{ #category : 'api - accessing' }
BlEventDispatcher >> handlers [
	^ Array streamContents: [ :aStream | self handlersDo: [ :eachHandler | aStream nextPut: eachHandler ] ]
]

{ #category : 'api - accessing' }
BlEventDispatcher >> handlersDo: aBlock [
	"Evaulate a given block with every event handler as an argument"
]

{ #category : 'api - testing' }
BlEventDispatcher >> hasEventHandlerSuchThat: aBlock [
	<return: #Boolean>

	self handlersDo: [ :eachHandler |
		(aBlock value: eachHandler)
			ifTrue: [ ^ true ] ].
		
	^ false
]

{ #category : 'api - accessing' }
BlEventDispatcher >> type [
	"Return the type name of the dispatcher. Might be used by IDE extensions"
	<return: #String>

	^ 'Silent'
]

{ #category : 'api - event managing' }
BlEventDispatcher >> wantsEvent: anEvent [
	"Return true if my current conditions allow me to dispatch a given event, false otherwise.
	Default implementation always returns true. Override me to customize the behaviour"
	<return: #Boolean>

	^ true
]
