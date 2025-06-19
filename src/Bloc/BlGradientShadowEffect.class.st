Class {
	#name : #BlGradientShadowEffect,
	#superclass : #BlShadowEffect,
	#instVars : [
		'width',
		'shadowSurface',
		'shadowSurfaceElementHash',
		'extraGap'
	],
	#category : #'Bloc-Effect'
}

{ #category : #'instance creation' }
BlGradientShadowEffect class >> color: aColor offset: anOffset width: aNumber [

	^ self color: aColor width: aNumber offset: anOffset
]

{ #category : #'instance creation' }
BlGradientShadowEffect class >> color: aColor width: aNumber offset: anOffset [

	^ self basicNew
		  initializeColor: aColor width: aNumber offset: anOffset;
		  yourself
]

{ #category : #private }
BlGradientShadowEffect >> elementHashFor: aBlElement [
	"Answer a hash that is enough to identify when something changed in the element, something that is relevant for this effect."

	^ aBlElement geometry hash bitXor: aBlElement extent hash
]

{ #category : #geometry }
BlGradientShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element."
	
	^ extraGap
]

{ #category : #initialization }
BlGradientShadowEffect >> initializeColor: aColor width: aWidth offset: aPoint [

	self initialize.

	color := aColor.
	width := aWidth.
	offset := aPoint.
	extraGap := width * 1.5
]
