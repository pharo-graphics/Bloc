Class {
	#name : #BlDropShadowEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'color',
		'width',
		'offset',
		'session',
		'cachedSurface',
		'cachedPath'
	],
	#category : #'Bloc-Effect'
}

{ #category : #'instance creation' }
BlDropShadowEffect class >> color: aColor width: aNumber offset: anOffset [
	^ self basicNew
		initializeColor: aColor
		width: aNumber
		offset: anOffset
]

{ #category : #'instance creation' }
BlDropShadowEffect class >> default [
	^ self
		color: (Color black alpha: 0.3)
		width: 15
		offset: 10@20
]

{ #category : #accessing }
BlDropShadowEffect >> color [
	<return: #Color>

	^ color
]

{ #category : #geometry }
BlDropShadowEffect >> computeBounds: aBlBounds [
	^ aBlBounds expandByMargin: self shadowMargin
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

{ #category : #geometry }
BlDropShadowEffect >> extraShadowSpace [
	"Compute extra space that should be freed for shadow around element.
	I depend on the width, and it is recommended to be 3 times of sigma (width) used for gaussian blur"
	
	^ self width * 3.0
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

{ #category : #initialization }
BlDropShadowEffect >> releaseCaches [
	cachedSurface ifNotNil: #release.
	cachedSurface := nil
]

{ #category : #geometry }
BlDropShadowEffect >> shadowMargin [
	| anExtraSpace |
	
	anExtraSpace := self extraShadowSpace.
	
	^ BlInsets
		top: ((anExtraSpace - self offset y) max: 0)
		right: ((anExtraSpace + self offset x) max: 0)
		bottom: ((anExtraSpace + self offset y) max: 0)
		left: ((anExtraSpace - self offset x) max: 0)
]

{ #category : #accessing }
BlDropShadowEffect >> width [
	<return: #Number>

	^ width
]
