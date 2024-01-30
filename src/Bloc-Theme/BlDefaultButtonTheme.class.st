Class {
	#name : 'BlDefaultButtonTheme',
	#superclass : 'BlTheme',
	#instVars : [
		'disabledBackgroundColor',
		'disabledTextColor',
		'disabledBorderColor',
		'pressedBorderColor',
		'defaultBorderColor',
		'defaultTextColor',
		'hoveredBorderColor',
		'pressedTextColor',
		'defaultBackgroundColor',
		'hoveredTextColor',
		'textHighlightColor',
		'hoveredBackgroundColor',
		'pressedBackgroundColor'
	],
	#category : 'Bloc-Theme',
	#package : 'Bloc-Theme'
}

{ #category : 'initialization' }
BlDefaultButtonTheme class >> isDeprecated [ 

	^ true
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredBackgroundColor [
	^ hoveredBackgroundColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredBackgroundColor: anObject [
	hoveredBackgroundColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredTextColor [
	^ hoveredTextColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> hoveredTextColor: anObject [
	hoveredTextColor := anObject
]

{ #category : 'initialization' }
BlDefaultButtonTheme >> initialize [
	super initialize.
	disabledBackgroundColor := BlDefaultColors disabledButtonBackgroundColor.
	disabledTextColor := BlDefaultColors disabledButtonTextColor.
	disabledBorderColor := BlDefaultColors disabledButtonBorderColor.
	pressedBorderColor := BlDefaultColors pressedButtonBorderColor.
	pressedBackgroundColor := BlDefaultColors pressedButtonBackgroundColor.
	defaultBorderColor := BlDefaultColors defaultButtonBorderColor.
	defaultTextColor := BlDefaultColors defaultButtonTextColor.
	hoveredBorderColor := BlDefaultColors hoveredButtonBorderColor.
	hoveredBackgroundColor := BlDefaultColors hoveredButtonBackgroundColor.
	pressedTextColor := BlDefaultColors pressedButtonTextColor.
	defaultBackgroundColor := BlDefaultColors defaultButtonBackgroundColor.
	hoveredTextColor := BlDefaultColors hoveredButtonTextColor.
	textHighlightColor := BlDefaultColors textHighlightColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedBackgroundColor [
	^ pressedBackgroundColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedBackgroundColor: aColor [
	pressedBackgroundColor := aColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedTextColor [
	^ pressedTextColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> pressedTextColor: anObject [
	pressedTextColor := anObject
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> textHighlightColor [
	^ textHighlightColor
]

{ #category : 'accessing' }
BlDefaultButtonTheme >> textHighlightColor: anObject [
	textHighlightColor := anObject
]
