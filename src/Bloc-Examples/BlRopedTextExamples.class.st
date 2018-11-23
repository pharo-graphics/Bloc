"
I contain examples of more complicated pieces of text to exemplify the rope structure.
"
Class {
	#name : #BlRopedTextExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Text'
}

{ #category : #'examples - next span' }
BlRopedTextExamples >> nextSpanFontColorOnHelloWorldWithColor [
	<gtExample>
	| aText anIterator aSpan |

	aText := 'Hello World' asRopedText.
	(aText from: 1 to: 5) foreground: Color red.
	(aText from: 7 to: 11) foreground: Color blue.

	anIterator := aText iterator.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 1.
	self assert: aSpan end equals: 5.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: 'Hello'.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 6.
	self assert: aSpan end equals: 6.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: ' '.
	
	aSpan := anIterator nextSpan: [ :eachAttribute| eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 7.
	self assert: aSpan end equals: 11.
	self assert: anIterator hasNext not.
	self assert: aSpan asString equals: 'World'.

	^ aSpan
]

{ #category : #examples }
BlRopedTextExamples >> textForeground [
	<gtExample>
	| text |

	"space between `Hello` and `world` is not attributed"
	text := 'Hello world' asRopedText.
	(text from: 1 to: 5) foreground: Color blue.
	(text from: 7 to: 11) foreground: Color red.

	self assert: text rope isConcatenation.
	self assert: text rope left isConcatenation.
	self assert: text rope left left size equals: 5.
	self assert: (text rope left left isKindOf: BlAttributeRope).
	self assert: text rope left left attributes asArray equals: { BlTextForegroundAttribute paint: Color blue }.
	self assert: (text rope right isKindOf: BlAttributeRope).
	self assert: text rope right attributes asArray equals: { BlTextForegroundAttribute paint: Color red }.

	^ text
]

{ #category : #examples }
BlRopedTextExamples >> textWithAttributes [
	<gtExample>
	| text |
	
	text := 'The moldable editor' asRopedText.
	text insertString: String cr at: text size.
	text insertString: 'can be adapted ' at: text size.
	text insertString: 'to the context.' at: text size.
	(text from: 5 to: 12)
		fontSize: 20;
		monospace;
		foreground: Color blue.

	(text from: 43 to: 49)
		monospace.

	^ text

]
