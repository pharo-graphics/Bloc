"
I am a custom event handler. User must override me and implement {{gtMethod:BlBasicEventHandler>>#eventsToHandle}} to return a collection of event classes that I am interested in.
Then for each interesting event a user should implement a corresponding event handling method. For example for `BlMouseDownEvent` it would be `mouseDownEvent:`

"
Class {
	#name : #BlCustomEventHandler,
	#superclass : #BlBasicEventHandler,
	#category : #'Bloc-Events-Handler'
}

{ #category : #'api - accessing' }
BlCustomEventHandler >> eventsToHandle [
	^ self subclassResponsibility
]

{ #category : #'api - event managing' }
BlCustomEventHandler >> handleEvent: anEvent [

	anEvent sendTo: self
]

{ #category : #'api - event managing' }
BlCustomEventHandler >> wantsEvent: anEvent [
	^ self eventsToHandle anySatisfy: [ :eachEventClass | anEvent isKindOf: eachEventClass ]
]
