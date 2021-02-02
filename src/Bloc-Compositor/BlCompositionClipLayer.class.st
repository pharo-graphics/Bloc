Class {
	#name : #BlCompositionClipLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'path',
		'offset'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionClipLayer >> asSymbolTree [
	^ {
		#Clip .
			#offset. { self offset x . self offset y }.
			#path. self path class name.
			self layers collect: [ :eachLayer | eachLayer asSymbolTree ] as: Array
	}
]

{ #category : #accessing }
BlCompositionClipLayer >> name [
	^ 'Clip'
]

{ #category : #converting }
BlCompositionClipLayer >> newSkiaLayer [
	<return: #SkiaCompositionClipLayer>

	^ self path spartaClipOn: self with: self
]

{ #category : #accessing }
BlCompositionClipLayer >> offset [
	^ offset
]

{ #category : #accessing }
BlCompositionClipLayer >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
BlCompositionClipLayer >> path [
	^ path
]

{ #category : #accessing }
BlCompositionClipLayer >> path: anObject [
	path := anObject
]

{ #category : #'private - clipping' }
BlCompositionClipLayer >> pushCircle: aSpartaCircle [
	^ SkiaCompositionClipLayer rectangle: aSpartaCircle asRectangle offset: self offset
]

{ #category : #'private - clipping' }
BlCompositionClipLayer >> pushEllipse: aSpartaEllipse [
	^ SkiaCompositionClipLayer rectangle: aSpartaEllipse asRectangle offset: self offset
]

{ #category : #'private - clipping' }
BlCompositionClipLayer >> pushPath: aSpartaPath [
	^ SkiaCompositionClipLayer path: aSpartaPath offset: self offset
]

{ #category : #'private - clipping' }
BlCompositionClipLayer >> pushRectangle: aRectangle [
	^ SkiaCompositionClipLayer rectangle: aRectangle offset: self offset
]

{ #category : #'private - clipping' }
BlCompositionClipLayer >> pushRoundedRectangle: aSpartaRoundedRectangle [
	^ SkiaCompositionClipLayer roundedRectangle: aSpartaRoundedRectangle offset: self offset
]
