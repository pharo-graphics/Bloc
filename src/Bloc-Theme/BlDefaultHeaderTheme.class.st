Class {
	#name : #BlDefaultHeaderTheme,
	#superclass : #BlTheme,
	#instVars : [
		'textMarkupColor',
		'defaultBackgroundColor',
		'disabledTextColor',
		'defaultTextColor',
		'secondaryBackgroundColor'
	],
	#category : #'Bloc-Theme'
}

{ #category : #accessing }
BlDefaultHeaderTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultHeaderTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
BlDefaultHeaderTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #initialization }
BlDefaultHeaderTheme >> initialize [
	super initialize.
	textMarkupColor := BlDefaultColors textMarkupColor.
	defaultBackgroundColor := BlDefaultColors
		defaultHeaderBackgroundColor.
	disabledTextColor := BlDefaultColors disabledHeaderTextColor.
	defaultTextColor := BlDefaultColors defaultHeaderTextColor.
	secondaryBackgroundColor := BlDefaultColors
		secondaryHeaderBackgroundColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> secondaryBackgroundColor [
	^ secondaryBackgroundColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> secondaryBackgroundColor: anObject [
	secondaryBackgroundColor := anObject
]

{ #category : #accessing }
BlDefaultHeaderTheme >> textMarkupColor [
	^ textMarkupColor
]

{ #category : #accessing }
BlDefaultHeaderTheme >> textMarkupColor: anObject [
	textMarkupColor := anObject
]
