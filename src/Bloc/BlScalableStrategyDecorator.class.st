"
I am a decorator of a scalable strategy and allow users to have a deeper customization of scalable element's behaviour
"
Class {
	#name : #BlScalableStrategyDecorator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'strategy'
	],
	#category : #'Bloc-Utilities - Scalable'
}

{ #category : #'instance creation' }
BlScalableStrategyDecorator class >> on: aScalableStrategy [
	"Create a new decorator instance that decorates a given strategy.
	aScalableStrategy must not be nil"
	<return: #BlScalableStrategyDecorator>

	^ self new strategy: aScalableStrategy
]

{ #category : #scale }
BlScalableStrategyDecorator >> scale: aContentElement within: aScalableElement [
	"Modify a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlScalableStrategyDecorator >> strategy [
	"Return a strategy of the scalable element that I am decorating"
	<return: #BlScalableStrategy>

	^ strategy
]

{ #category : #accessing }
BlScalableStrategyDecorator >> strategy: aScalableStrategy [

	self
		assert: [ aScalableStrategy isNotNil ]
		description: [ 'Scalable strategy must not be nil' ].

	strategy := aScalableStrategy
]
