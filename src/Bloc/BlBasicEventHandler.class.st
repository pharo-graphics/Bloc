Class {
	#name : #BlBasicEventHandler,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Events-Handler'
}

{ #category : #'api - hooks' }
BlBasicEventHandler >> disableEventsIn: anElementEventDispatcher [
	self eventsToHandle do: [ :eachEventClass | eachEventClass disableIn: anElementEventDispatcher ]
]

{ #category : #'api - hooks' }
BlBasicEventHandler >> enableEventsIn: anElementEventDispatcher [
	self eventsToHandle do: [ :eachEventClass | eachEventClass enableIn: anElementEventDispatcher ]
]

{ #category : #'api - accessing' }
BlBasicEventHandler >> eventsToHandle [
	"I return a collection of element types I may be interested in"
	<return: #Collection of: #'BlEvent class'>	

	^ #()
]

{ #category : #'api - event managing' }
BlBasicEventHandler >> handleEvent: anEvent [
]

{ #category : #'api - hooks' }
BlBasicEventHandler >> onInstalledIn: anObject [
]

{ #category : #'api - hooks' }
BlBasicEventHandler >> onUninstalledIn: anObject [
]

{ #category : #'api - event managing' }
BlBasicEventHandler >> wantsEvent: anEvent [
	^ false
]
