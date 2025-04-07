"
I have been automatically converted and probably manually tweaked from BlRopedTextExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlRopedTextTest2,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Tests'
}

{ #category : #tests }
BlRopedTextTest2 >> testAllAttributesSuchThat [

	<sampleInstance>
	| aText theAttributes |
	aText := 'Hello World' asRopedText.
	aText
		attribute: (BlTextForegroundAttribute color: Color red)
		from: 1
		to: 5.
	aText
		attribute: (BlTextForegroundAttribute color: Color blue)
		from: 6
		to: 11.

	theAttributes := aText attributesAndIndicesSuchThat: [ :each | true ].
	self assert: theAttributes size equals: 2.
	self assert: theAttributes first value equals: (1 to: 5).
	self assert: theAttributes second value equals: (6 to: 11).

	^ aText
]

{ #category : #tests }
BlRopedTextTest2 >> testAppendEmptyText [

	<sampleInstance>
	| aText wasAnnounced |
	aText := 'Hello' asRopedText.

	wasAnnounced := 0.
	aText
		when: BlTextStringsInserted
		do: [ wasAnnounced := wasAnnounced + 1 ]
		for: self.

	aText , '' asRopedText.

	self assert: aText asString equals: 'Hello'.
	self assert: wasAnnounced equals: 0.

	^ aText
]

{ #category : #tests }
BlRopedTextTest2 >> testInsertEmptyStrings [

	<sampleInstance>
	| aText insertedStrings |
	aText := 'Hello' asRopedText.

	insertedStrings := #(  ).
	aText
		when: BlTextStringsInserted
		do: [ :anAnnouncement | insertedStrings := anAnnouncement strings ]
		for: self.

	aText insertStrings: { ''. 'World' } atAll: { 1. 5 }.

	self assert: aText asString equals: 'HelloWorld'.
	self assert: insertedStrings equals: { 'World' }.

	^ aText
]

{ #category : #tests }
BlRopedTextTest2 >> testNextSpanFontColorOnHelloWorldWithColor [

	<sampleInstance>
	| aText anIterator aSpan |
	aText := 'Hello World' asRopedText.
	(aText from: 1 to: 5) foreground: Color red.
	(aText from: 7 to: 11) foreground: Color blue.

	anIterator := aText iterator.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 1.
	self assert: aSpan end equals: 5.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: 'Hello'.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 6.
	self assert: aSpan end equals: 6.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: ' '.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan start equals: 7.
	self assert: aSpan end equals: 11.
	self assert: anIterator hasNext not.
	self assert: aSpan asString equals: 'World'.

	^ aText
]

{ #category : #tests }
BlRopedTextTest2 >> testTextForeground [

	<sampleInstance>
	| text |
	"space between `Hello` and `world` is not attributed"
	text := 'Hello world' asRopedText.
	(text from: 1 to: 5) foreground: Color blue.
	(text from: 7 to: 11) foreground: Color red.

	self assert: text rope isConcatenation.

	self assert: text rope left size equals: 5.
	self assert: (text rope left isKindOf: BlAttributeRope).
	self
		assert: text rope left attributes asArray
		equals: { (BlTextForegroundAttribute paint: Color blue) }.

	self assert: text rope right isConcatenation.

	self assert: text rope right right size equals: 5.
	self assert: (text rope right right isKindOf: BlAttributeRope).
	self
		assert: text rope right right attributes asArray
		equals: { (BlTextForegroundAttribute paint: Color red) }.

	^ text
]

{ #category : #tests }
BlRopedTextTest2 >> testTextWithAttributes [

	<sampleInstance>
	| text |
	text := 'The moldable editor' asRopedText.
	text insertString: String cr at: text size.
	text insertString: 'can be adapted ' at: text size.
	text insertString: 'to the context.' at: text size.
	(text from: 5 to: 12)
		fontSize: 20;
		monospace;
		foreground: Color blue.

	(text from: 43 to: 49) monospace.

	^ text
]

{ #category : #tests }
BlRopedTextTest2 >> testTextWithCr [

	<sampleInstance>
	| text |
	text := ('Hello' , String crlf , String tab , 'World') asRopedText.

	^ text
]
