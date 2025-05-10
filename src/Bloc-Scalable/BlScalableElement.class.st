"
I'm a helper element that transforms its #contentElement in order to exactly #scaleTo:  my size.

## Example:

```
	| content scalable |
	
	content := BlElement new 
		size: 20@20;
		background: Color red.
	
	scalable := BlScalableElement new.
	scalable scaleStrategy: (BlScalableFixedStrategy zoom: 2). ""set custom zoom level""
	scalable scaleStrategy: (BlScalableFitWidthStrategy new). ""Fit horizontally""
	scalable scaleStrategy: (BlScalableFitHeightStrategy new). ""Fit vertically""
	scalable scaleStrategy: (BlScalableFitAllStrategy new). ""Fit vertically and horizontally at the same time""
	scalable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	scalable contentElement: content.
	scalable
```

"
Class {
	#name : #BlScalableElement,
	#superclass : #BlElement,
	#instVars : [
		'contentElement',
		'scaleStrategy'
	],
	#category : #'Bloc-Scalable-Core'
}

{ #category : #'instance creation' }
BlScalableElement class >> on: anElement [
	^ self new contentElement: anElement
]

{ #category : #accessing }
BlScalableElement >> contentElement [
	"Return a content element that is being scaled"
	<return: #BlElement>

	self
		assert: [ contentElement isNotNil ]
		description: [ 'Can not access a content element when it is not provided' ].

	^ contentElement
]

{ #category : #accessing }
BlScalableElement >> contentElement: anElement [
	"Specify an element that should be scaled according to my size.
	If I already have a content element, it will be replaced with a new one.
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Content element must not be nil' ].

	self addChild: anElement
]

{ #category : #initialization }
BlScalableElement >> defaultScaleStrategy [
	<return: #BlScalableStrategy>

	^ BlScalableFitAllStrategy new
]

{ #category : #'api - scaling' }
BlScalableElement >> fitAll [
	self scaleStrategy: BlScalableFitAllStrategy new
]

{ #category : #'api - scaling' }
BlScalableElement >> fitHeight [
	self scaleStrategy: BlScalableFitHeightStrategy new
]

{ #category : #'api - scaling' }
BlScalableElement >> fitWidth [
	self scaleStrategy: BlScalableFitWidthStrategy new
]

{ #category : #testing }
BlScalableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>
	
	^ contentElement isNotNil
]

{ #category : #initialization }
BlScalableElement >> initialize [
	super initialize.

	scaleStrategy := self defaultScaleStrategy
]

{ #category : #'api - scaling' }
BlScalableElement >> maxScale: aNumber [
	self scaleStrategy: ((BlScalableMaxDecorator on: self scaleStrategy) maxScale: aNumber)
]

{ #category : #layout }
BlScalableElement >> measureMatching: anExtentMeasurementSpec [
	| widthSpec heightSpec aTransformedBounds |
	
	aTransformedBounds := self contentElement transformation inverseTransformBounds: self measuredBounds bounds.

	widthSpec := self contentElement constraints horizontal resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds width ]
		ifFalse: [ 
			self layout
				measurementSpecFor: anExtentMeasurementSpec widthSpec
				usedSize: 0.0
				resizer: self contentElement constraints horizontal resizer ].
			
	heightSpec := self contentElement constraints vertical resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds height ]
		ifFalse: [
			self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0.0
				resizer: self contentElement constraints vertical resizer ].
			
	self contentElement measure: widthSpec @ heightSpec
]

{ #category : #layout }
BlScalableElement >> measureScale [
	"Compute and return a scale factor of the content element based on the current scale strategy"
	| aScaleFactor |
	<return: #Number>

	self hasContentElement
		ifFalse: [ ^ 1.0 ].
	
	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self scaleStrategy scale: self contentElement within: self.
	"we must not scale by zero! Otherwise matrix becomes singular"
	aScaleFactor isZero
		ifTrue: [ aScaleFactor := 1.0 ].
		
	^ aScaleFactor
]

{ #category : #'api - scaling' }
BlScalableElement >> minScale: aNumber [
	self scaleStrategy: ((BlScalableMinDecorator on: self scaleStrategy) minScale: aNumber)
]

{ #category : #'hooks - children' }
BlScalableElement >> onChildAdded: anElement [
	"I make sure that there is only one child"
	super onChildAdded: anElement.

	"If we already have a content element, we should remove an old one
	in order to replace it with one just provided"
	self hasContentElement
		ifTrue: [ self removeChild: self contentElement ].

	contentElement := anElement
]

{ #category : #layout }
BlScalableElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	| aContentBounds |

	self hasContentElement
		ifFalse: [ ^ self ].

	aContentBounds := BlBounds origin: 0.0@0.0 extent: self contentElement measuredExtent.
	aContentBounds translateBy: (self measuredExtent - aContentBounds extent) / 2.0.
	
	self contentElement applyLayoutIn: aContentBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
BlScalableElement >> onMeasure: anExtentMeasurementSpec [

	| aScaleFactor |
	"First we perform a default measurement"
	super onMeasure: anExtentMeasurementSpec.

	self hasContentElement ifFalse: [ ^ self ].

	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self measureScale.

	self contentElement transformDo: [ :t |
		t scaleBy: aScaleFactor @ aScaleFactor ].

	self measuredExtent:
		(anExtentMeasurementSpec sizeFor:
			self contentElement measuredBounds transformed extent)
]

{ #category : #accessing }
BlScalableElement >> scaleStrategy [
	"Return scale strategy used to compute scaling factor of the content element"
	self
		assert: [ scaleStrategy isNotNil ]
		description: [ 'Scale strategy can not be nil' ].
		
	^ scaleStrategy
]

{ #category : #accessing }
BlScalableElement >> scaleStrategy: aBlScalableStrategy [
	"Set scale strategy used to compute scaling factor of the content element.
	Note: I request layout update"
	self
		assert: [ aBlScalableStrategy isNotNil ]
		description: [ 'Scalable strategy must not be nil' ].
		
	scaleStrategy := aBlScalableStrategy.
	self requestLayout
]
