Class {
	#name : #BlDefaultDividerTheme,
	#superclass : #BlTheme,
	#instVars : [
		'disabledBackgroundColor',
		'disabledBorderColor',
		'pressedBorderColor',
		'defaultBorderColor',
		'hoveredBorderColor',
		'defaultBackgroundColor',
		'hoveredBackgroundColor',
		'pressedBackgroundColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #initialization }
BlDefaultDividerTheme class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
BlDefaultDividerTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultDividerTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : #accessing }
BlDefaultDividerTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultDividerTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : #accessing }
BlDefaultDividerTheme >> hoveredBackgroundColor [
	^ hoveredBackgroundColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> hoveredBackgroundColor: anObject [
	hoveredBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultDividerTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : #initialization }
BlDefaultDividerTheme >> initialize [
	super initialize.
	defaultBorderColor := BlDefaultColors defaultDividerBorderColor.
	defaultBackgroundColor := BlDefaultColors defaultDividerBackgroundColor.
	disabledBackgroundColor := BlDefaultColors disabledDividerBackgroundColor.
	disabledBorderColor := BlDefaultColors disabledDividerBorderColor.
	pressedBorderColor := BlDefaultColors pressedDividerBorderColor.
	pressedBackgroundColor := BlDefaultColors pressedDividerBackgroundColor.
	hoveredBorderColor := BlDefaultColors hoveredDividerBorderColor.
	hoveredBackgroundColor := BlDefaultColors hoveredDividerBackgroundColor.

]

{ #category : #accessing }
BlDefaultDividerTheme >> pressedBackgroundColor [
	^ pressedBackgroundColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> pressedBackgroundColor: aColor [
	pressedBackgroundColor := aColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
BlDefaultDividerTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]
