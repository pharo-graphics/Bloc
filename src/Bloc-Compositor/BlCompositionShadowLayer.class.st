Class {
	#name : #BlCompositionShadowLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'offset',
		'shadowOffset',
		'shadowColor',
		'shadowWidth',
		'shadowPath'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionShadowLayer >> name [
	^ 'Shadow'
]

{ #category : #converting }
BlCompositionShadowLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: self offset
]

{ #category : #accessing }
BlCompositionShadowLayer >> offset [
	^ offset
]

{ #category : #accessing }
BlCompositionShadowLayer >> offset: anObject [
	offset := anObject
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
