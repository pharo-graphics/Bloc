Class {
	#name : #BlCompositionTransformationLayer,
	#superclass : #BlCompositionOffsetLayer,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionTransformationLayer >> asSkiaLayer [
	|  aTransformationLayer theChildLayers |

	aTransformationLayer := self newSkiaLayer.
	
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	theChildLayers do: [ :eachLayer | aTransformationLayer addLayer: eachLayer ].
	
	^ self offset isZero
		ifTrue: [ aTransformationLayer ]
		ifFalse: [
			| anOffsetLayer |
			anOffsetLayer := super newSkiaLayer.
			anOffsetLayer addLayer: aTransformationLayer.
			anOffsetLayer ]
]

{ #category : #accessing }
BlCompositionTransformationLayer >> matrix [
	^ matrix
]

{ #category : #accessing }
BlCompositionTransformationLayer >> matrix: anObject [
	matrix := anObject
]

{ #category : #accessing }
BlCompositionTransformationLayer >> name [
	^ 'Transform {1}' format: { self offset }
]

{ #category : #converting }
BlCompositionTransformationLayer >> newSkiaLayer [
	^ SkiaCompositionTransformationLayer matrix: self matrix
]
