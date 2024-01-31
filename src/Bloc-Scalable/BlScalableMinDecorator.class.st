"
I allow users to specify a minimum scale value of the content inside of scalable element.

Deafult min scale is set to 1.0

"
Class {
	#name : 'BlScalableMinDecorator',
	#superclass : 'BlScalableStrategyDecorator',
	#instVars : [
		'minScale'
	],
	#category : 'Bloc-Scalable-Strategies',
	#package : 'Bloc-Scalable',
	#tag : 'Strategies'
}

{ #category : 'initialization' }
BlScalableMinDecorator >> initialize [
	super initialize.
	
	minScale := 1.0
]

{ #category : 'accessing' }
BlScalableMinDecorator >> minScale [
	"Return a minimum scale factor of the content element inside of scalable element"
	<return: #Number>
	
	^ minScale
]

{ #category : 'accessing' }
BlScalableMinDecorator >> minScale: aNumber [
	self
		assert: [ aNumber > 0 ]
		description: [ 'Scale factor must be greater than 0' ].
		
	minScale := aNumber
]

{ #category : 'scale' }
BlScalableMinDecorator >> scale: aContentElement within: aScalableElement [
	"Modify a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ (self strategy scale: aContentElement within: aScalableElement) max: self minScale
]
