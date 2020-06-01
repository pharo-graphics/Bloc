Class {
	#name : #BlCompositionContainerLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'children'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #removing }
BlCompositionContainerLayer >> addLayer: aBlCompositionLayer [
	children add: aBlCompositionLayer.
	aBlCompositionLayer attachToParent: self
]

{ #category : #converting }
BlCompositionContainerLayer >> asSkiaLayer [
	| aLayer theChildLayers |

	aLayer := self newSkiaLayer.
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	theChildLayers do: [ :eachLayer | aLayer addLayer: eachLayer ].
	
	^ aLayer
]

{ #category : #accessing }
BlCompositionContainerLayer >> children [
	^ self layers
]

{ #category : #drawing }
BlCompositionContainerLayer >> drawOnSpartaCanvas: aCanvas [
	self layers do: [ :eachLayer | eachLayer drawOnSpartaCanvas: aCanvas ]
]

{ #category : #initialization }
BlCompositionContainerLayer >> initialize [
	super initialize.
	
	children := OrderedCollection new
]

{ #category : #accessing }
BlCompositionContainerLayer >> layers [
	<return: #Collection of: #BlCompositionLayer>

	^ children
]

{ #category : #accessing }
BlCompositionContainerLayer >> name [
	^ 'Container'
]

{ #category : #converting }
BlCompositionContainerLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: 0@0
]

{ #category : #removing }
BlCompositionContainerLayer >> removeAllLayers [
	children do: [ :each | each detachFromParent ].
	children := OrderedCollection new
]

{ #category : #removing }
BlCompositionContainerLayer >> removeLayer: aBlCompositionLayer [
	children remove: aBlCompositionLayer.
	aBlCompositionLayer detachFromParent
]

{ #category : #removing }
BlCompositionContainerLayer >> swapLayer: aChildLayer and: anOtherLayer [
	| aFirstIndex aSecondIndex |
	
	aFirstIndex := children indexOf: aChildLayer.
	aSecondIndex := children indexOf: anOtherLayer.
	
	children at: aFirstIndex put: anOtherLayer.
	children at: aSecondIndex put: aChildLayer.
]

{ #category : #removing }
BlCompositionContainerLayer >> wrapLayer: aChildLayer in: anOtherLayer [
	| anIndex |
	
	anIndex := children indexOf: aChildLayer.
	aChildLayer detachFromParent.
	
	anOtherLayer addLayer: aChildLayer.
	children at: anIndex put: anOtherLayer.
	anOtherLayer attachToParent: self
]
