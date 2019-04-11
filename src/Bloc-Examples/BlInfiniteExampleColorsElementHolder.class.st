"
I bind a color to its visual representation - a colored rectangle element
"
Class {
	#name : #BlInfiniteExampleColorsElementHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'color'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteExampleColorsElementHolder >> color [
	^ color
]

{ #category : #accessing }
BlInfiniteExampleColorsElementHolder >> color: aColor [

	color := aColor.	
	"color changed, update element to represent new color"
	itemElement background: color
]

{ #category : #initialization }
BlInfiniteExampleColorsElementHolder >> initialize [
	super initialize.

	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40.
			c margin: (BlInsets bottom: 3) ];
		yourself
]
