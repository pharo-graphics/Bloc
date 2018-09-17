Class {
	#name : #BlDropShadowEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'color',
		'width',
		'offset'
	],
	#category : 'Bloc-Effect'
}

{ #category : #'instance creation' }
BlDropShadowEffect class >> color: aColor width: aNumber offset: anOffset [
	^ self basicNew
		initializeColor: aColor
		width: aNumber
		offset: anOffset
]

{ #category : #accessing }
BlDropShadowEffect >> color [
	<return: #Color>

	^ color
]

{ #category : #geometry }
BlDropShadowEffect >> computeBounds: aSpartaRectangle [
	| aLeft aTop aRight aBottom |

	aLeft := (self width - self offset x) max: 0.
	aTop := (self width - self offset y) max: 0.
	aRight := (self width + self offset x) max: 0.
	aBottom := (self width + self offset y) max: 0.

	^ aSpartaRectangle
		expandByLeft: aLeft
		top: aTop
		right: aRight
		bottom: aBottom
]

{ #category : #copying }
BlDropShadowEffect >> copyWithColor: aColor [
	<return: #BlDropShadowEffect>

	^ self class
		color: aColor
		width: self width
		offset: self offset
]

{ #category : #copying }
BlDropShadowEffect >> copyWithOffset: aPoint [
	<return: #BlDropShadowEffect>

	^ self class
		color: self color
		width: self width
		offset: aPoint
]

{ #category : #copying }
BlDropShadowEffect >> copyWithWidth: aNumber [
	<return: #BlDropShadowEffect>

	^ self class
		color: self color
		width: aNumber
		offset: self offset
]

{ #category : #initialization }
BlDropShadowEffect >> initialize [
	super initialize.

	self
		initializeColor: Color black
		width: 10
		offset: 0@0
]

{ #category : #initialization }
BlDropShadowEffect >> initializeColor: aColor width: aWidth offset: aPoint [
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

{ #category : #accessing }
BlDropShadowEffect >> offset [
	<return: #Point>

	^ offset
]

{ #category : #accessing }
BlDropShadowEffect >> width [
	<return: #Number>

	^ width
]
