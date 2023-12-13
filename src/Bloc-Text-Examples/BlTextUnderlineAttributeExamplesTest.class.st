"
# Underline attribute

The simplest way to apply an underline attribute on a whole text would be to use {{gtMethod:TBlTextStyleable>>#underlineColor:thickness:}}
{{gtExample:BlTextUnderlineAttributeExamples>>#textWithUnderline_1_to_5|previewShow=#gtTextFor:|previewExpanded|previewHeight=100}}

To add an underline to just a part of text it can be scoped with {{gtMethod:BlText>>#from:to:}}
{{gtExample:BlTextUnderlineAttributeExamples>>#textWithUnderline_3_to_4|previewShow=#gtTextFor:|previewExpanded|previewHeight=100}}

In addition to the simple API an underline attribute can be customized and then applied on a text using {{gtMethod:TBlTextStyleable>>#underlineDo:}} helper method. Users should pass a block that accepts {{gtClass:BlTextDecorationAttribute}} as an argument.
{{gtExample:BlTextUnderlineAttributeExamples>>#textWithUnderlineDo|previewShow=#gtTextFor:|previewExpanded|previewHeight=100}}

"
Class {
	#name : #BlTextUnderlineAttributeExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #attribute }
BlTextUnderlineAttributeExamplesTest >> lineOfUnderlineAttribute [

	<sampleInstance>
	self error: 'TODO: migrate from Sparta'

	"	| anAttribute aCanvas aSpan aLine |

	anAttribute := self underlineAttribute.
	aSpan := BlMockedTextParagraphSpan new
		left: -5;
		baseline: 20@10;
		advance: 30.
		
	aCanvas := Bloc preferableSpartaCanvas offscreen.
	
	aLine := anAttribute lineOnSpartaCanvas: aCanvas with: aSpan.
	self assert: (aLine containsPoint: 21@12 on: aCanvas).
	self assert: (aLine containsPoint: 50@12 on: aCanvas).

	^ aLine"
]

{ #category : #attribute }
BlTextUnderlineAttributeExamplesTest >> testUnderlineAttribute [

	<sampleInstance>
	| anAttribute |
	anAttribute := BlTextDecorationAttribute new underline.

	self assert: anAttribute thickness equals: 1.
	self assert: anAttribute color equals: Color black.

	^ anAttribute
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> text [

	<sampleInstance>
	^ 'Hello' asRopedText
		  fontSize: 75;
		  foreground: Color veryDarkGray
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderlineDo [

	<sampleInstance>
	^ self text underlineDo: [ :anUnderline |
		  anUnderline
			  color: Color red;
			  thickness: 6 ]
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderline_1_to_5 [

	<sampleInstance>
	^ self text underlineColor: (Color red alpha: 0.5) thickness: 6
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderline_2_to_3 [

	<sampleInstance>
	| aText |
	aText := self text.
	(aText from: 2 to: 3)
		underlineColor: (Color red alpha: 0.5)
		thickness: 6.
	^ aText
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderline_2_to_4 [

	<sampleInstance>
	| aText |
	aText := self text.
	(aText from: 2 to: 4)
		underlineColor: (Color red alpha: 0.5)
		thickness: 6.
	^ aText
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderline_3_to_4 [

	<sampleInstance>
	| aText |
	aText := self text.
	(aText from: 3 to: 4)
		underlineColor: (Color red alpha: 0.5)
		thickness: 6.
	^ aText
]

{ #category : #accessing }
BlTextUnderlineAttributeExamplesTest >> textWithUnderline_3_to_5 [

	<sampleInstance>
	| aText |
	aText := self text.
	(aText from: 3 to: 5)
		underlineColor: (Color red alpha: 0.5)
		thickness: 6.
	^ aText
]
