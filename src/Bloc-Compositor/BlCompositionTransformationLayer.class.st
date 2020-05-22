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
	| anOffsetLayer aTransformationLayer theChildLayers |

	anOffsetLayer := super newSkiaLayer.
	aTransformationLayer := self newSkiaLayer.
	
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	theChildLayers do: [ :eachLayer | aTransformationLayer addLayer: eachLayer ].
	
	anOffsetLayer addLayer: aTransformationLayer.
	
	^ anOffsetLayer
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
	^ 'Transform'
]

{ #category : #converting }
BlCompositionTransformationLayer >> newSkiaLayer [
	^ SkiaCompositionTransformationLayer matrix: self matrix
]
