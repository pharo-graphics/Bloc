Class {
	#name : #BlFontAndStyleBuilder,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#instVars : [
		'color',
		'decoration'
	],
	#category : #'Bloc-Text-Font'
}

{ #category : #'text - style' }
BlFontAndStyleBuilder >> color [
	<return: #Color>

	^ color
]

{ #category : #'text - style' }
BlFontAndStyleBuilder >> color: aColor [
	color := aColor
]

{ #category : #'text - style' }
BlFontAndStyleBuilder >> decoration [
	<return: #BlTextDecoration>

	^ decoration
]

{ #category : #'text - style' }
BlFontAndStyleBuilder >> decoration: aBlTextDecoration [
	decoration := aBlTextDecoration
]

{ #category : #accessing }
BlFontAndStyleBuilder >> font [
	<return: #TBlFont>

	^ self
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomColor [
	^ color notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomDecoration [
	^ decoration notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFamilyName [
	^ fontFamilyName notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFontSize [
	^ fontSize notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFontSlant [
	^ fontSlant notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFontStretch [
	^ fontStretch notNil
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFontStyle [
	^ self hasCustomFontSlant or: [ self hasCustomFontStretch or: [ self hasCustomFontWeight ] ]
]

{ #category : #testing }
BlFontAndStyleBuilder >> hasCustomFontWeight [
	^ fontWeight notNil
]

{ #category : #initialization }
BlFontAndStyleBuilder >> initialize [
	super initialize.
]
