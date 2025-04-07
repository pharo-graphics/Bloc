"
I am very simple shadow effect. I just render a plain flat colored geometry of an element on which I am applied with an offset.

"
Class {
	#name : #BlSimpleShadowEffect,
	#superclass : #BlShadowEffect,
	#category : #'Bloc-Effect'
}

{ #category : #'instance creation' }
BlSimpleShadowEffect class >> color: aColor offset: anOffset [

	^ self basicNew
		  initializeColor: aColor offset: anOffset;
		  yourself
]

{ #category : #'instance creation' }
BlSimpleShadowEffect class >> new [

	^ self color: Color black offset: 0@0
]

{ #category : #copying }
BlSimpleShadowEffect >> copyWithColor: aColor [

	^ self class
		color: aColor
		offset: offset
]

{ #category : #copying }
BlSimpleShadowEffect >> copyWithOffset: aPoint [

	^ self class
		color: color
		offset: aPoint
]

{ #category : #geometry }
BlSimpleShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element.
	Since I am not a gaussian shadow, the extra shadow space should be equal to the shadow width"
	
	^ 0
]

{ #category : #initialization }
BlSimpleShadowEffect >> initializeColor: aColor offset: aPoint [

	self initialize.

	color := aColor.
	offset := aPoint asPoint
]
