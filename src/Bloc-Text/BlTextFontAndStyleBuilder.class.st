Class {
	#name : #BlTextFontAndStyleBuilder,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#instVars : [
		'color',
		'decoration',
		'defaultFontSize'
	],
	#category : #'Bloc-Text-Text-Support'
}

{ #category : #'text - style' }
BlTextFontAndStyleBuilder >> color [
	<return: #Color>

	^ color
]

{ #category : #'text - style' }
BlTextFontAndStyleBuilder >> color: aColor [
	color := aColor
]

{ #category : #'text - style' }
BlTextFontAndStyleBuilder >> decoration [
	<return: #BlTextDecoration>

	^ decoration
]

{ #category : #'text - style' }
BlTextFontAndStyleBuilder >> decoration: aBlTextDecoration [
	decoration := aBlTextDecoration
]

{ #category : #'font - size' }
BlTextFontAndStyleBuilder >> defaultFontSizePt: aNumber [
	self
		assert: [ aNumber isNumber ]
		description: [ 'Must be a number' ].

	defaultFontSize := aNumber
]

{ #category : #accessing }
BlTextFontAndStyleBuilder >> font [
	| aFont |
	
	aFont := BlFont new.
	
	self hasCustomFamilyName
		ifTrue: [ aFont familyName: self familyName ].
	self hasCustomFontSize
		ifTrue: [ aFont fontSize: self resolvedFontSize ].
	self hasCustomFontSlant
		ifTrue: [ aFont fontSlant: self fontSlant ].
	self hasCustomFontStretch
		ifTrue: [ aFont fontStretch: self fontStretch ].
	self hasCustomFontWeight
		ifTrue: [ aFont fontWeight: self fontWeight ].

	^ aFont
]

{ #category : #accessing }
BlTextFontAndStyleBuilder >> fontPropertiesTarget [
	<return: #TBlFont>

	^ self
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomColor [
	^ color notNil
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomDecoration [
	^ decoration notNil
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFamilyName [
	^ fontFamilyName notNil
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFontSize [
	^ fontSize notNil or: [ defaultFontSize notNil ]
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFontSlant [
	^ fontSlant notNil
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFontStretch [
	^ fontStretch notNil
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFontStyle [
	^ self hasCustomFontSlant or: [ self hasCustomFontStretch or: [ self hasCustomFontWeight ] ]
]

{ #category : #testing }
BlTextFontAndStyleBuilder >> hasCustomFontWeight [
	^ fontWeight notNil
]

{ #category : #initialization }
BlTextFontAndStyleBuilder >> initialize [
	super initialize
]

{ #category : #'font - size' }
BlTextFontAndStyleBuilder >> resolvedFontSize [	
	<return: #BlValueWithUnit>

	^ fontSize
		ifNil: [ BlValueWithUnit pt: defaultFontSize ]
		ifNotNil: [ :aNotYetResolvedFontSize |
			BlValueWithUnit pt: (aNotYetResolvedFontSize unit
				resolveLengthForValue: aNotYetResolvedFontSize value
				parent: [ defaultFontSize ifNil: [ BlFont defaultFontSize ] ]
				global: [ defaultFontSize ifNil: [ BlFont defaultFontSize ] ]) ]
]
