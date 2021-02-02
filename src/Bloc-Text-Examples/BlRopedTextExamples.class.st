"
I contain examples of more complicated pieces of text to exemplify the rope structure.
"
Class {
	#name : #BlRopedTextExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'example - insert' }
BlRopedTextExamples >> append_empty_text [
	<gtExample>
	| aText wasAnnounced |
	
	aText := 'Hello' asRopedText.
	
	wasAnnounced := 0.
	aText when: BlTextStringsInserted do: [ wasAnnounced := wasAnnounced + 1 ].

	aText, '' asRopedText.

	self assert: aText asString equals: 'Hello'.
	self assert: wasAnnounced equals: 0.

	^ aText
]

{ #category : #'example - insert' }
BlRopedTextExamples >> insert_empty_strings [
	<gtExample>
	| aText insertedStrings |
	
	aText := 'Hello' asRopedText.
	
	insertedStrings := #().
	aText when: BlTextStringsInserted do: [ :anAnnouncement |
		insertedStrings := anAnnouncement strings.
	].

	aText insertStrings: { '' . 'World' } atAll: { 1 . 5 }.

	self assert: aText asString equals: 'HelloWorld'.
	self assert: insertedStrings equals: { 'World' }.

	^ aText
]

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

	^ aText
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
	
	self assert: text rope left size equals: 5.
	self assert: (text rope left isKindOf: BlAttributeRope).
	self assert: text rope left attributes asArray equals: { BlTextForegroundAttribute paint: Color blue }.

	self assert: text rope right isConcatenation.

	self assert: text rope right right size equals: 5.
	self assert: (text rope right right isKindOf: BlAttributeRope).
	self assert: text rope right right attributes asArray equals: { BlTextForegroundAttribute paint: Color red }.

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

{ #category : #examples }
BlRopedTextExamples >> textWithCr [
	<gtExample>
	| text |

	text := ('Hello', String crlf, String tab, 'World') asRopedText.

	^ text
]
