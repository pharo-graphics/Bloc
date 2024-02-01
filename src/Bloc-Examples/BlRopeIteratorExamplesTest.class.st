"
I contain examples of rope iterators

"
Class {
	#name : #BlRopeIteratorExamplesTest,
	#superclass : #TestCase,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #'examples - next span' }
BlRopeIteratorExamplesTest >> testNextSpanFontColorOnA [

	<sampleInstance>
	| aRope anIterator aSpan |
	aRope := BlCollectionRope collection: 'A'.
	anIterator := aRope iterator.
	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].

	self assert: aSpan == aRope.
	self assert: anIterator hasNext not.

	^ aSpan
]

{ #category : #'examples - next span' }
BlRopeIteratorExamplesTest >> testNextSpanFontColorOnAWithColor [

	<sampleInstance>
	| aRope anIterator aSpan |
	aRope := (BlCollectionRope collection: 'A') attributes:
		         { (BlTextForegroundAttribute paint: Color red) }.

	anIterator := aRope iterator.
	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].

	self assert: aSpan == aRope.
	self assert: anIterator hasNext not.

	^ aSpan
]

{ #category : #'examples - next span' }
BlRopeIteratorExamplesTest >> testNextSpanFontColorOnHelloWorldWithColor [

	<sampleInstance>
	| aRope anIterator aSpan |
	aRope := BlCollectionRope collection: 'Hello World'.
	aRope := aRope
		         attributes:
		         { (BlTextForegroundAttribute paint: Color red) }
		         from: 0
		         to: 5.
	aRope := aRope
		         attributes:
		         { (BlTextForegroundAttribute paint: Color blue) }
		         from: 6
		         to: 11.

	anIterator := aRope iterator.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope left.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: 'Hello'.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope right left.
	self assert: anIterator hasNext.
	self assert: aSpan asString equals: ' '.

	aSpan := anIterator nextSpan: [ :eachAttribute |
		         eachAttribute isKindOf: BlTextForegroundAttribute ].
	self assert: aSpan == aRope right right.
	self assert: anIterator hasNext not.
	self assert: aSpan asString equals: 'World'.

	^ aSpan
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_123Cr_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: '123' , String cr)
		              iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 3.
		self assert: anEndDelimiter equals: 4 ].

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_123Crabc_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: '123' , String cr , 'abc')
		              iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 3.
		self assert: anEndDelimiter equals: 4 ].

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_123Crabc_at_4 [

	<sampleInstance>
	| anIterator |
	anIterator := self testNext_line_123Crabc_at_0.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 4.
		self assert: anEnd equals: 7.
		self assert: anEndDelimiter equals: 7 ].

	self assert: anIterator position equals: 7.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_123_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: '123') iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 3.
		self assert: anEndDelimiter equals: 3 ].

	self assert: anIterator position equals: 3.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Cr123_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String cr , '123')
		              iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 1 ].

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Cr123_at_1 [

	<sampleInstance>
	| anIterator |
	anIterator := self testNext_line_Cr123_at_0.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 1.
		self assert: anEnd equals: 4.
		self assert: anEndDelimiter equals: 4 ].

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Cr1_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String cr , '1') iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 1 ].

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Cr1_at_1 [

	<sampleInstance>
	| anIterator |
	anIterator := self testNext_line_Cr1_at_0.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 1.
		self assert: anEnd equals: 2.
		self assert: anEndDelimiter equals: 2 ].

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_CrCr_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String cr , String cr)
		              iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 1 ].

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_CrCr_at_1 [

	<sampleInstance>
	| anIterator |
	anIterator := self testNext_line_CrCr_at_0.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 1.
		self assert: anEnd equals: 1.
		self assert: anEndDelimiter equals: 2 ].

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_CrLf_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String crlf) iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 2 ].

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Cr_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String cr) iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 1 ].

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next line' }
BlRopeIteratorExamplesTest >> testNext_line_Lf_at_0 [

	<sampleInstance>
	| anIterator |
	anIterator := (BlCollectionRope collection: String lf) iterator.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimiter |
		self assert: aStart equals: 0.
		self assert: anEnd equals: 0.
		self assert: anEndDelimiter equals: 1 ].

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next segment' }
BlRopeIteratorExamplesTest >> testNext_segment_123abc_at_0 [

	<sampleInstance>
	| aRope anIterator aSegment |
	aRope := BlCollectionRope collection: '123abc'.
	anIterator := aRope iterator.

	aSegment := anIterator nextSegment: [ :aChar | aChar isDigit ].

	self assert: aSegment collection equals: '123'.
	self assert: anIterator position equals: 3.

	^ anIterator
]

{ #category : #'examples - next segment' }
BlRopeIteratorExamplesTest >> testNext_segment_123abc_at_3 [

	<sampleInstance>
	| anIterator aSegment |
	anIterator := self testNext_segment_123abc_at_0.

	aSegment := anIterator nextSegment: [ :aChar | aChar isDigit ].

	self assert: aSegment collection equals: 'abc'.
	self assert: anIterator position equals: 6.

	^ anIterator
]

{ #category : #'examples - next segment' }
BlRopeIteratorExamplesTest >> testNext_segment_123abc_at_6 [
	"Iterator throws an error when the end is reached"

	<sampleInstance>
	| anIterator anError |
	anIterator := self testNext_segment_123abc_at_3.

	anError := nil.
	[ anIterator nextSegment: [ :aChar | aChar isDigit ] ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - next segment' }
BlRopeIteratorExamplesTest >> testNext_segment_a_at_0 [

	<sampleInstance>
	| aRope anIterator aSegment |
	aRope := BlCollectionRope collection: 'a'.
	anIterator := aRope iterator.

	aSegment := anIterator nextSegment: [ :aChar | aChar isDigit ].

	self assert: aSegment collection equals: 'a'.
	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - next segment' }
BlRopeIteratorExamplesTest >> testNext_segment_abc_at_0 [

	<sampleInstance>
	| aRope anIterator aSegment |
	aRope := BlCollectionRope collection: 'abc'.
	anIterator := aRope iterator.

	aSegment := anIterator nextSegment: [ :aChar | aChar isDigit ].

	self assert: aSegment collection equals: 'abc'.
	self assert: anIterator position equals: 3.

	^ anIterator
]
