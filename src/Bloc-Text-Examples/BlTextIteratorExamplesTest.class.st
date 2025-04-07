Class {
	#name : #BlTextIteratorExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Examples-Model'
}

{ #category : #'instance creation' }
BlTextIteratorExamplesTest >> newTextSizeTenAttribute [

	^ BlFontSizeAttribute size: 10
]

{ #category : #'instance creation' }
BlTextIteratorExamplesTest >> testAttributed_end [

	<sampleInstance>
	| aText anIterator |
	aText := 'EarthHelloWorld' asRopedText.

	(aText from: 11 to: 15) attribute: self newTextSizeTenAttribute.

	anIterator := aText iterator.
	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testAttributed_end_next_attributed_end_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testAttributed_end.

	anIterator
		nextAttributedEnd: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_end_next_span_any_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_end.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_end_next_span_any_at_10 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_end_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'instance creation' }
BlTextIteratorExamplesTest >> testAttributed_middle [

	<sampleInstance>
	| aText anIterator |
	aText := 'EarthHelloWorld' asRopedText.

	(aText from: 6 to: 10) attribute: self newTextSizeTenAttribute.

	anIterator := aText iterator.
	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testAttributed_middle_next_attributed_end_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testAttributed_middle.

	anIterator
		nextAttributedEnd: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testAttributed_middle_next_attributed_end_at_10 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testAttributed_middle_next_attributed_end_at_1.

	anIterator
		nextAttributedEnd: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_middle_next_span_any_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_middle.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_middle_next_span_any_at_10 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_middle_next_span_any_at_5.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 11.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_middle_next_span_any_at_5 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_middle_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 6.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'instance creation' }
BlTextIteratorExamplesTest >> testAttributed_start [

	<sampleInstance>
	| aText anIterator |
	aText := 'EarthHelloWorld' asRopedText.

	(aText from: 1 to: 5) attribute: self newTextSizeTenAttribute.

	anIterator := aText iterator.
	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testAttributed_start_next_attributed_end_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testAttributed_start.

	anIterator
		nextAttributedEnd: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: theAdornmentAttributes size equals: 1.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testAttributed_start_next_attributed_end_at_5 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testAttributed_start_next_attributed_end_at_1.

	anIterator
		nextAttributedEnd: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 6.
	self assert: anEnd equals: 15.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_start_next_span_any_at_1 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_start.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 5.
	self assert: hasAnyAttribute.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testAttributed_start_next_span_any_at_5 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testAttributed_start_next_span_any_at_1.

	anIterator
		nextSpanAny: [ :eachAttribute |
			eachAttribute = self newTextSizeTenAttribute ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 6.
	self assert: anEnd equals: 15.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_beginning [

	<sampleInstance>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 1
		        to: 5.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).

	^ text
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_beginning_subtext_equal [

	<sampleInstance>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 1
		        to: 5.

	subText := text from: 1 to: 5.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).

	^ subText
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_beginning_subtext_larger [

	<sampleInstance>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 1
		        to: 5.

	subText := text from: 1 to: 7.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 5).

	^ subText
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_beginning_subtext_shifted [

	<sampleInstance>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 1
		        to: 5.

	subText := text from: 3 to: 7.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 3).

	^ subText
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_beginning_subtext_smaller [

	<sampleInstance>
	| attribute text subText interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 1
		        to: 5.

	subText := text from: 1 to: 2.

	subText
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (1 to: 2).

	^ subText
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_end [

	<sampleInstance>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 6
		        to: 10.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (6 to: 10).

	^ text
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_middle [

	<sampleInstance>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText
		        attributes: { attribute }
		        from: 3
		        to: 7.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval equals: (3 to: 7).

	^ text
]

{ #category : #'examples - attribute indices' }
BlTextIteratorExamplesTest >> testFindAttribute_none [

	<sampleInstance>
	| attribute text interval |
	attribute := BlTextForegroundAttribute paint: Color red.

	text := 'HelloWorld' asRopedText.

	text
		findAttribute: attribute
		indicesDo: [ :aStart :anEnd | interval := aStart to: anEnd ].

	self assert: interval isNil.

	^ text
]

{ #category : #'instance creation' }
BlTextIteratorExamplesTest >> testSimple [

	<sampleInstance>
	| anIterator |
	anIterator := 'HelloWorld' asRopedText iterator.
	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : #'examples - attributed end' }
BlTextIteratorExamplesTest >> testSimple_next_attributed_end_at_0 [

	<sampleInstance>
	| anIterator aStart anEnd theAdornmentAttributes |
	anIterator := self testSimple.

	anIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :theAttributes |
			aStart := indexStart.
			anEnd := indexEnd.
			theAdornmentAttributes := theAttributes ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: theAdornmentAttributes isEmpty.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - span any' }
BlTextIteratorExamplesTest >> testSimple_next_span_any_at_0 [

	<sampleInstance>
	| anIterator aStart anEnd hasAnyAttribute |
	anIterator := self testSimple.

	anIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :indexStart :indexEnd :hasAny |
			aStart := indexStart.
			anEnd := indexEnd.
			hasAnyAttribute := hasAny ].

	self assert: aStart equals: 1.
	self assert: anEnd equals: 10.
	self assert: hasAnyAttribute not.
	self assert: anIterator position equals: 10.

	^ anIterator
]
