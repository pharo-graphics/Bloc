Class {
	#name : #BlCompositionOffsetLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'offset',
		'skiaLayer'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionOffsetLayer >> asSkiaLayer [
	<return: #SkiaCompositionOffsetLayer>

	skiaLayer
		ifNil: [
			| theChildLayers |
			skiaLayer := self newSkiaLayer.
			theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
			theChildLayers do: [ :eachLayer | skiaLayer addLayer: eachLayer ] ]
		ifNotNil: [ skiaLayer offset: self offset ].

	^ skiaLayer
]

{ #category : #drawing }
BlCompositionOffsetLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas transform
		by: [ :t | t translateBy: self offset ]
		during: [ super drawOnSpartaCanvas: aCanvas ]
]

{ #category : #initialization }
BlCompositionOffsetLayer >> initialize [
	super initialize.
	
	offset := 0@0
]

{ #category : #accessing }
BlCompositionOffsetLayer >> name [
	^ 'Offset {1}' format: { self offset }
]

{ #category : #converting }
BlCompositionOffsetLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: self offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> offset [
	<return: #Number>

	^ offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> offset: aNumber [
	offset := aNumber
]
