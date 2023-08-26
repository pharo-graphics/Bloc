Class {
	#name : #BlDefaultItemTheme,
	#superclass : #BlTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'focusedBorderColor',
		'hoveredBorderColor',
		'pressedBorderColor',
		'hoveredBackgroundColor',
		'defaultBackgroundColor',
		'pressedBackgroundColor',
		'selectedBlurredColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlDefaultItemTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BlDefaultItemTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #initialization }
BlDefaultItemTheme >> defaultBorderColor [

	^ self deselectedColor 
]

{ #category : #accessing }
BlDefaultItemTheme >> deselectedColor [
	^ deselectedColor
]

{ #category : #accessing }
BlDefaultItemTheme >> deselectedColor: anObject [
	deselectedColor := anObject
]

{ #category : #accessing }
BlDefaultItemTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BlDefaultItemTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #accessing }
BlDefaultItemTheme >> hoveredBackgroundColor [
	^ hoveredBackgroundColor
]

{ #category : #accessing }
BlDefaultItemTheme >> hoveredBackgroundColor: anObject [
	hoveredBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultItemTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #initialization }
BlDefaultItemTheme >> initialize [
	super initialize.
	selectedColor := BlDefaultColors selectedListItemColor.
	deselectedColor := BlDefaultColors deselectedListItemColor.
	hoveredBackgroundColor := BlDefaultColors hoveredListItemBackgroundColor.
	hoveredBorderColor := BlDefaultColors hoveredListItemBorderColor.
	defaultBackgroundColor := BlDefaultColors defaultListItemBackgroundColor.
	focusedBorderColor := BlDefaultColors focusedListItemBorder.
	pressedBorderColor := BlDefaultColors pressedListItemBorderColor.
	pressedBackgroundColor := BlDefaultColors pressedListItemColor
]

{ #category : #accessing }
BlDefaultItemTheme >> pressedBackgroundColor [
	^ pressedBackgroundColor
]

{ #category : #accessing }
BlDefaultItemTheme >> pressedBackgroundColor: anObject [
	pressedBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultItemTheme >> pressedBorderColor [

	^ pressedBorderColor
]

{ #category : #accessing }
BlDefaultItemTheme >> pressedBorderColor: aColor [

	pressedBorderColor := aColor
]

{ #category : #accessing }
BlDefaultItemTheme >> selectedBlurredColor [
	^ selectedBlurredColor ifNil: [selectedBlurredColor := self selectedColor muchLighter ]
]

{ #category : #accessing }
BlDefaultItemTheme >> selectedColor [

	^ selectedColor
]

{ #category : #accessing }
BlDefaultItemTheme >> selectedColor: anObject [
	selectedColor := anObject
]
