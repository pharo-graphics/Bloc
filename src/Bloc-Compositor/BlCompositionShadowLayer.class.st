Class {
	#name : #BlCompositionShadowLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'shadowOffset',
		'shadowColor',
		'shadowWidth',
		'shadowPath'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionShadowLayer >> asSkiaLayer [
	|  aShadowLayer theChildLayers |

	aShadowLayer := self newSkiaLayer.
	
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	theChildLayers do: [ :eachLayer | aShadowLayer addLayer: eachLayer ].
	
	^ self offset isZero
		ifTrue: [ aShadowLayer ]
		ifFalse: [
			| anOffsetLayer |
			anOffsetLayer := super newSkiaLayer.
			anOffsetLayer addLayer: aShadowLayer.
			anOffsetLayer ]
]

{ #category : #converting }
BlCompositionShadowLayer >> asSymbolTree [
	^ {
		#Shadow .
			#offset. { self offset x . self offset y }.
			#shadowOffset . { self shadowOffset x. self shadowOffset y }.
			#shadowColor . { self shadowColor red .  self shadowColor green . self shadowColor blue . self shadowColor alpha }.
			#shadowWidth . self shadowWidth.
			#shadowPath . self shadowPath class name.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionShadowLayer >> name [
	^ 'Shadow'
]

{ #category : #converting }
BlCompositionShadowLayer >> newSkiaLayer [
	<return: #SkiaCompositionShadowLayer>
	| aSkiaLayer |
	
	aSkiaLayer := SkiaCompositionShadowLayer
		color: self shadowColor
		radius: (self shadowWidth / 1.2) asPoint
		offset: self shadowOffset.

	self shadowPath spartaClipOn: self with: aSkiaLayer.
	
	^ aSkiaLayer
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowColor: anObject [
	shadowColor := anObject
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowOffset [
	^ shadowOffset
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowOffset: anObject [
	shadowOffset := anObject
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowPath [
	^ shadowPath
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowPath: anObject [
	shadowPath := anObject
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowWidth [
	^ shadowWidth
]

{ #category : #accessing }
BlCompositionShadowLayer >> shadowWidth: anObject [
	shadowWidth := anObject
]
