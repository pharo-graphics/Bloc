"
I'm a `BlElement` composition layer, that cache rasterization when the element's compositingMode requires it, i.e. when the element responds true to wantsSeparateCompositingLayer.

"
Class {
	#name : #BACompositionLayer,
	#superclass : #Object,
	#instVars : [
		'offset',
		'surface'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #testing }
BACompositionLayer >> isValid [
	
	^ surface isNull not
]

{ #category : #accessing }
BACompositionLayer >> offset [

	^ offset
]

{ #category : #accessing }
BACompositionLayer >> offset: aPoint [

	offset := aPoint
]

{ #category : #removing }
BACompositionLayer >> removeFromParent [
	"This layer is being detached from it's element"
	
	"'detach ' trace. surface identityHash traceCr."
]

{ #category : #accessing }
BACompositionLayer >> surface [

	^ surface
]

{ #category : #accessing }
BACompositionLayer >> surface: aCairoSurface [

	surface := aCairoSurface
]
