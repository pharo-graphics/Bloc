"
I am very simple shadow effect. I just render a plain flat colored geometry of an element on which I am applied with an offset.

"
Class {
	#name : 'BlSimpleShadowEffect',
	#superclass : 'BlShadowEffect',
	#category : 'Bloc-Effect'
}

{ #category : 'as yet unclassified' }
BlSimpleShadowEffect class >> color: aColor offset: anOffset [
	^ self basicNew
		initializeColor: aColor
		offset: anOffset
]

{ #category : 'accessing' }
BlSimpleShadowEffect class >> default [
	^ self
		color: (Color black alpha: 0.3)
		offset: 10@10
]

{ #category : 'copying' }
BlSimpleShadowEffect >> copyWithColor: aColor [
	<return: #BlShadowEffect>

	^ self class
		color: aColor
		offset: self offset
]

{ #category : 'copying' }
BlSimpleShadowEffect >> copyWithOffset: aPoint [
	<return: #BlShadowEffect>

	^ self class
		color: self color
		offset: aPoint
]

{ #category : 'geometry' }
BlSimpleShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element.
	Since I am not a gaussian shadow, the extra shadow space should be equal to the shadow width"
	
	^ 0
]

{ #category : 'initialization' }
BlSimpleShadowEffect >> initializeColor: aColor offset: aPoint [
	self
		assert: [ color isNil ]
		description: [ 'Can not change a color! Shadow is immutable' ].
		
	self
		assert: [ offset isNil ]
		description: [ 'Can not change an offset! Shadow is immutable' ].

	color := aColor.
	offset := aPoint asPoint
]
