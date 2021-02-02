Class {
	#name : #BlCompositionOffsetLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'skiaLayer'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionOffsetLayer >> asSkiaLayer [
	<return: #SkiaCompositionOffsetLayer>

	(skiaLayer isNil or: [ self needsComposition ])
		ifTrue: [
			| theChildLayers |
			skiaLayer := self newSkiaLayer.
			theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
			theChildLayers do: [ :eachLayer | skiaLayer addLayer: eachLayer ] ]
		ifFalse: [ skiaLayer offset: self offset ].

	^ skiaLayer
]

{ #category : #converting }
BlCompositionOffsetLayer >> asSymbolTree [
	^ {
		#Offset .
			#offset. { self offset x . self offset y }.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #drawing }
BlCompositionOffsetLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas transform
		by: [ :t | t translateBy: self offset ]
		during: [ super drawOnSpartaCanvas: aCanvas ]
]

{ #category : #'private - context' }
BlCompositionOffsetLayer >> multiplyOn: aBlMatrix2D [
	aBlMatrix2D translateBy: self offset
]

{ #category : #accessing }
BlCompositionOffsetLayer >> name [
	^ 'Offset {1}' format: { self offset }
]

{ #category : #converting }
BlCompositionOffsetLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: self offset
]
