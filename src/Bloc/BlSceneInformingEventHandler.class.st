"
I am an abstract class.
My subclasses can be attached to ${class:BlSceneInformingElement}$ and perform corresponding actions.

See my subclasses, ${class:BlSceneInformingEventHandler|show=#gtSubclassesFor:|height=150|expanded=true}$
"
Class {
	#name : #BlSceneInformingEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'valuable'
	],
	#category : #'Bloc-Events-Handling'
}

{ #category : #accessing }
BlSceneInformingEventHandler >> eventClass [
	^ self subclassResponsibility
]

{ #category : #'api - event managing' }
BlSceneInformingEventHandler >> handleEvent: anEvent [
	self valuable cull: anEvent
]

{ #category : #initialization }
BlSceneInformingEventHandler >> initialize [
	super initialize.
	valuable := [ :anEvent | "do nothing" ].
]

{ #category : #accessing }
BlSceneInformingEventHandler >> valuable [
	"Return a object that understands #cull:"
	^ valuable
]

{ #category : #accessing }
BlSceneInformingEventHandler >> valuable: aValuable [
	self 
		assert: [ aValuable isNotNil ] 
		description: [ 'Event handler valuable object must be non-nil' ].
	valuable := aValuable
]

{ #category : #'api - event managing' }
BlSceneInformingEventHandler >> wantsEvent: anEvent [
	^ anEvent class = self eventClass
]
