"
I use gaussian blur to produce a smooth shadow in a form of element's geometry.
The use of gaussian shadow is quite expensive in terms of rendering. Therefore I implement a drawing cache of the blurred shadow itself

"
Class {
	#name : #BlGaussianShadowEffect,
	#superclass : #BlShadowEffect,
	#instVars : [
		'width',
		'alphaSurface',
		'alphaSurfaceElementHash'
	],
	#category : #'Bloc-Effect'
}

{ #category : #'instance creation' }
BlGaussianShadowEffect class >> color: aColor offset: anOffset width: aNumber [ 

	^ self color: aColor width: aNumber offset: anOffset
]

{ #category : #'instance creation' }
BlGaussianShadowEffect class >> color: aColor width: aNumber offset: anOffset [

	^ self basicNew
		  initializeColor: aColor width: aNumber offset: anOffset;
		  yourself
]

{ #category : #'instance creation' }
BlGaussianShadowEffect class >> new [

	^ self
		color: Color black
		width: 10
		offset: 0@0
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithColor: aColor [

	^ self class
		color: aColor
		width: self width
		offset: self offset
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithOffset: aPoint [

	^ self class
		color: self color
		width: self width
		offset: aPoint
]

{ #category : #copying }
BlGaussianShadowEffect >> copyWithWidth: aNumber [

	^ self class
		color: self color
		width: aNumber
		offset: self offset
]

{ #category : #geometry }
BlGaussianShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element.
	I depend on the width, and it is recommended to be 3 times of sigma (width) used for gaussian blur"
	
	^ self width * 1.5
]

{ #category : #initialization }
BlGaussianShadowEffect >> initializeColor: aColor width: aWidth offset: aPoint [

	self initialize.

	color := aColor.
	width := aWidth.
	offset := aPoint asPoint
]

{ #category : #testing }
BlGaussianShadowEffect >> wantsCompositionLayer [
	"See: https://github.com/pharo-graphics/Bloc/issues/543"

	^ false
]

{ #category : #accessing }
BlGaussianShadowEffect >> width [

	^ width
]
