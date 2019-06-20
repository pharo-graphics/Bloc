Class {
	#name : #BlTextOrientationAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'orientation'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #factory }
BlTextOrientationAttribute class >> horizontal [
	^ self new horizontal
]

{ #category : #factory }
BlTextOrientationAttribute class >> vertical [
	^ self new verticalSidewaysRight
]

{ #category : #factory }
BlTextOrientationAttribute >> horizontal [
	orientation := #horizontal
]

{ #category : #initialization }
BlTextOrientationAttribute >> initialize [
	super initialize.

	self horizontal
]

{ #category : #testing }
BlTextOrientationAttribute >> isHorizontal [
	^ orientation = #horizontal
]

{ #category : #testing }
BlTextOrientationAttribute >> isVertical [
	^ self isHorizontal not
]

{ #category : #factory }
BlTextOrientationAttribute >> verticalMixed [
	"Rotates the characters of horizontal scripts 90° clockwise. Lays out the characters of vertical scripts naturally."
	orientation := #verticalMixed
]

{ #category : #factory }
BlTextOrientationAttribute >> verticalSidewaysLeft [
	"LCauses characters to be laid out as they would be horizontally, but with the whole line rotated 90° clockwise."
	orientation := #verticalSidewaysLeft
]

{ #category : #factory }
BlTextOrientationAttribute >> verticalSidewaysRight [
	"Causes characters to be laid out as they would be horizontally, but with the whole line rotated 90° clockwise and then mirrored"
	orientation := #verticalSidewaysRight
]

{ #category : #factory }
BlTextOrientationAttribute >> verticalUpright [
	"Lays out the characters of horizontal scripts naturally (upright), as well as the glyphs for vertical scripts. Note that this keyword causes all characters to be considered as left-to-right: the used value of direction is forced to be ltr."
	orientation := #verticalUpright
]
