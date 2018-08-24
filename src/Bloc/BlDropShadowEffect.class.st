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
	^ self new
		color: aColor;
		width: aNumber;
		offset: anOffset
]

{ #category : #accessing }
BlDropShadowEffect >> color [
	^ color
]

{ #category : #accessing }
BlDropShadowEffect >> color: aColor [
	color := aColor
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

{ #category : #initialization }
BlDropShadowEffect >> initialize [
	super initialize.
	
	color := Color black.
	width := 10.
	offset := 0@0
]

{ #category : #accessing }
BlDropShadowEffect >> offset [
	^ offset
]

{ #category : #accessing }
BlDropShadowEffect >> offset: aPointOrNumber [
	offset := aPointOrNumber asPoint
]

{ #category : #accessing }
BlDropShadowEffect >> width [
	^ width
]

{ #category : #accessing }
BlDropShadowEffect >> width: aNumber [
	width := aNumber
]
