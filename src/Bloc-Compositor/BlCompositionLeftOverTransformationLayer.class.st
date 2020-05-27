Class {
	#name : #BlCompositionLeftOverTransformationLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'matrix'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionLeftOverTransformationLayer >> matrix [
	^ matrix
]

{ #category : #accessing }
BlCompositionLeftOverTransformationLayer >> matrix: anObject [
	matrix := anObject
]

{ #category : #accessing }
BlCompositionLeftOverTransformationLayer >> name [
	^ 'Leftover transform'
]

{ #category : #converting }
BlCompositionLeftOverTransformationLayer >> newSkiaLayer [
	^ SkiaCompositionTransformationLayer matrix: self matrix
]

{ #category : #accessing }
BlCompositionLeftOverTransformationLayer >> offset: anOffset [
	self children do: [ :eachLayer | eachLayer offset: anOffset ]
]
