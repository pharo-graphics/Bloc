"
I use gaussian blur to produce a smooth shadow in a form of element's geometry.
The use of gaussian shadow is quite expensive in terms of rendering. Therefore I implement a drawing cache of the blurred shadow itself
"
Class {
	#name : #BlGaussianShadowEffect,
	#superclass : #BlShadowEffect,
	#instVars : [
		'width',
		'session',
		'cachedSurface',
		'cachedPath'
	],
	#category : #'Bloc-Effect'
}

{ #category : #'instance creation' }
BlGaussianShadowEffect class >> color: aColor width: aNumber offset: anOffset [
	^ self basicNew
		initializeColor: aColor
		width: aNumber
		offset: anOffset
]

{ #category : #'instance creation' }
BlGaussianShadowEffect class >> default [
	^ self
		color: (Color black alpha: 0.3)
		width: 15
		offset: 10@20
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithColor: aColor [
	<return: #BlShadowEffect>

	^ self class
		color: aColor
		width: self width
		offset: self offset
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithOffset: aPoint [
	<return: #BlShadowEffect>

	^ self class
		color: self color
		width: self width
		offset: aPoint
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithWidth: aNumber [
	<return: #BlShadowEffect>

	^ self class
		color: self color
		width: aNumber
		offset: self offset
]

{ #category : #geometry }
BlGaussianShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element.
	I depend on the width, and it is recommended to be 3 times of sigma (width) used for gaussian blur"
	
	^ self width * 3.0
]

{ #category : #initialization }
BlGaussianShadowEffect >> initializeColor: aColor width: aWidth offset: aPoint [
	self
		assert: [ color isNil ]
		description: [ 'Can not change a color! Shadow is immutable' ].
		
	self
		assert: [ width isNil ]
		description: [ 'Can not change a width! Shadow is immutable' ].
		
	self
		assert: [ offset isNil ]
		description: [ 'Can not change an offset! Shadow is immutable' ].

	color := aColor.
	width := aWidth.
	offset := aPoint asPoint
]

{ #category : #initialization }
BlGaussianShadowEffect >> releaseCaches [
	cachedSurface ifNotNil: #release.
	cachedSurface := nil
]

{ #category : #accessing }
BlGaussianShadowEffect >> width [
	<return: #Number>

	^ width
]
