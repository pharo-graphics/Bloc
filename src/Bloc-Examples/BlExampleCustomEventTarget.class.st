"
I am an example of a custom non-element event target that can be nicely integrated in bloc infrastructure

"
Class {
	#name : #BlExampleCustomEventTarget,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : 'Bloc-Examples-Event'
}

{ #category : #accessing }
BlExampleCustomEventTarget >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
BlExampleCustomEventTarget >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self
]
