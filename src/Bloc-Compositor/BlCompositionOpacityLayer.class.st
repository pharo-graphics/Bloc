Class {
	#name : #BlCompositionOpacityLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'opacity',
		'offset'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionOpacityLayer >> name [
	^ 'Opacity'
]

{ #category : #accessing }
BlCompositionOpacityLayer >> offset [
	^ offset
]

{ #category : #accessing }
BlCompositionOpacityLayer >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
BlCompositionOpacityLayer >> opacity [
	^ opacity
]

{ #category : #accessing }
BlCompositionOpacityLayer >> opacity: anObject [
	opacity := anObject
]
