Class {
	#name : #BlTextStyleBuilder,
	#superclass : #Object,
	#traits : 'TBlFontDescriptor + TBlFont',
	#classTraits : 'TBlFontDescriptor classTrait + TBlFont classTrait',
	#instVars : [
		'color',
		'decoration'
	],
	#category : #'Bloc-Text-Font'
}

{ #category : #accessing }
BlTextStyleBuilder >> color [
	^ color
]

{ #category : #accessing }
BlTextStyleBuilder >> color: anObject [
	color := anObject
]

{ #category : #accessing }
BlTextStyleBuilder >> decoration [
	^ decoration
]

{ #category : #accessing }
BlTextStyleBuilder >> decoration: aTextDecoration [
	decoration := aTextDecoration
]

{ #category : #accessing }
BlTextStyleBuilder >> font [
	<return: #TBlFont>

	^ self
]

{ #category : #testing }
BlTextStyleBuilder >> hasCustomColor [
	^ color notNil
]

{ #category : #testing }
BlTextStyleBuilder >> hasCustomDecoration [
	^ decoration notNil
]

{ #category : #testing }
BlTextStyleBuilder >> hasCustomFamilyName [
	^ familyName notNil
]

{ #category : #testing }
BlTextStyleBuilder >> hasCustomFontSize [
	^ fontSize notNil
]

{ #category : #testing }
BlTextStyleBuilder >> hasCustomFontStyle [
	^ stretch notNil or: [ style notNil or: [ weight notNil ] ]
]

{ #category : #initialization }
BlTextStyleBuilder >> initialize [
	super initialize.
]

{ #category : #'api - attributes' }
BlTextStyleBuilder >> named: anObject [
	self familyName: anObject
]

{ #category : #'api - attributes' }
BlTextStyleBuilder >> paint: aBlPaint [
	self color: aBlPaint
]

{ #category : #'api - attributes' }
BlTextStyleBuilder >> spacing: aNumber [
]
