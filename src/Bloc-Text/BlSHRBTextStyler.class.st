"
I adapt the Shout text styler to work with `BlRopedText` instead of `Text`.
"
Class {
	#name : #BlSHRBTextStyler,
	#superclass : #SHRBTextStyler,
	#instVars : [
		'blocText'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #attributes }
BlSHRBTextStyler class >> attributeArrayForColor: aColorOrNil emphasis: anEmphasisOrArrayOrNil [
	"Return a collection of text or font attributes for given color (or nil)
	and array of requested emphasis styles (#bold, #italic, #oblique or #normal)"

	^ Array streamContents: [ :aStream |

		aColorOrNil ifNotNil: [ :eachColor |
			aStream nextPut: (self foregroundAttributeFor: eachColor) ].

		anEmphasisOrArrayOrNil ifNotNil: [
			(anEmphasisOrArrayOrNil isSymbol
				ifTrue: [ { anEmphasisOrArrayOrNil } ]
				ifFalse: [ anEmphasisOrArrayOrNil ]) do: [ :eachEmphasis |
					aStream nextPut: (self emphasisAttributeFor: eachEmphasis) ] ]
		]
]

{ #category : #attributes }
BlSHRBTextStyler class >> attributeArrayForColor: aColorOrNil emphasis: anEmphasisOrArrayOrNil font: font [
	"This is for backwards-compatibility with Pharo 11"

	^ self attributeArrayForColor: aColorOrNil emphasis: anEmphasisOrArrayOrNil
]

{ #category : #attributes }
BlSHRBTextStyler class >> emphasisAttributeFor: anEmphasisAsSymbol [
	"Create and return a text emphasis attribute for a given emphasis.
	anEmphasisAsSymbol can be either #bold #italic #oblique or #normal"
	
	anEmphasisAsSymbol = #bold
		ifTrue: [ ^ BlFontWeightAttribute bold ].
	
	anEmphasisAsSymbol = #italic
		ifTrue: [ ^ BlFontEmphasisAttribute italic ].
		
	anEmphasisAsSymbol = #oblique
		ifTrue: [ ^ BlFontEmphasisAttribute oblique ].
		
	anEmphasisAsSymbol = #normal
		ifTrue: [ ^ BlFontEmphasisAttribute normal ].
	
	anEmphasisAsSymbol = #light
		ifTrue: [ ^ BlFontWeightAttribute light ].

	self error: 'Unknown emphasis: ', anEmphasisAsSymbol asString
]

{ #category : #attributes }
BlSHRBTextStyler class >> foregroundAttributeFor: aPaint [
	"Create and return a text foreground attribute for a given paint.
	aPaint can be a color, gradient or any other object that represents a paint
	and is polymorphic with a canvas-specific paint or that knows how to convert
	itself to an actual paint using double dispatch."

	^ BlTextForegroundAttribute paint: aPaint
]

{ #category : #formatting }
BlSHRBTextStyler >> addAttributes: attributes from: start to: stop [

	blocText
		attributes: (attributes collect: [ :each | each asBlTextAttribute ])
		from: start to: stop
]

{ #category : #private }
BlSHRBTextStyler >> style: aBlText ast: ast [

	aBlText ifEmpty: [ ^ self ].
	blocText := aBlText.

	bracketLevel := 0.
	parentheseLevel := 0.
	braceLevel := 0.

	self visitNode: ast.
	"Second pass to ensure that all syntax errors are visible"
	ast allErrorNotices do: [ :notice |
		notice isSyntaxError ifTrue: [
			self addStyle: #invalid from: notice position to: notice position ] ].

	blocText := nil.

	^ aBlText
]
