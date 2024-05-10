"
I am an example of a custom non-element event target that can be nicely integrated in bloc infrastructure

"
Class {
	#name : #BlMockedEventTarget,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Bloc-Tests-Events'
}

{ #category : #accessing }
BlMockedEventTarget >> eventDispatcher [
	"Return an object responsible for event dispatching"

	^ eventDispatcher
]

{ #category : #initialization }
BlMockedEventTarget >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self
]
