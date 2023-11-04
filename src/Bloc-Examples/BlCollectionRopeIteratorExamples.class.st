Class {
	#name : 'BlCollectionRopeIteratorExamples',
	#superclass : 'Object',
	#category : 'Bloc-Examples-Rope',
	#package : 'Bloc-Examples',
	#tag : 'Rope'
}

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineIndicesWithCrlf_0 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := (BlCollectionRope collection: ('Line 1', String crlf, 'Line 2', String crlf, String crlf, 'Line 4')) iterator.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 8.
	self assert: aNextLine equals: {  0 . 6 . 8 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 1'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineIndicesWithCrlf_08 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineIndicesWithCrlf_0.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 16.
	self assert: aNextLine equals: {  8 . 14 . 16 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 2'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineIndicesWithCrlf_16 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineIndicesWithCrlf_08.
	
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 18.
	self assert: aNextLine equals: { 16 . 16 . 18 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: ''.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineIndicesWithCrlf_18 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineIndicesWithCrlf_16.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 24.
	self assert: aNextLine equals: {  18 . 24 . 24 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 4'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithCr_0 [
	<sampleInstance>
	| anIterator aNextLine |
	
	anIterator := (BlCollectionRope collection: ('Line 1', String cr, 'Line 2', String cr, String cr, 'Line 4')) iterator.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 7.
	self assert: aNextLine equals: {  0 . 6 . 7 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 1'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithCr_07 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithCr_0.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 14.
	self assert: aNextLine equals: {  7 . 13 . 14 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 2'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithCr_14 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithCr_07.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 15.
	self assert: aNextLine equals: {  14 . 14 . 15 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: ''.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithCr_15 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithCr_14.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 21.
	self assert: aNextLine equals: {  15 . 21 . 21 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 4'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithCrlf [
	<gtExample>
	| anIterator |
	
	anIterator := (BlCollectionRope collection: ('Line 1', String crlf, 'Line 2', String crlf, String crlf, 'Line 4')) iterator.

	self assert: anIterator nextLine asString equals: 'Line 1'.
	self assert: anIterator nextLine asString equals: 'Line 2'.
	self assert: anIterator nextLine asString equals: ''.
	self assert: anIterator nextLine asString equals: 'Line 4'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithLf_0 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := (BlCollectionRope collection: ('Line 1', String lf, 'Line 2', String lf, String lf, 'Line 4')) iterator.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 7.
	self assert: aNextLine equals: {  0 . 6 . 7 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 1'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithLf_07 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithLf_0.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 14.
	self assert: aNextLine equals: {  7 . 13 . 14 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 2'.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithLf_14 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithLf_07.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 15.
	self assert: aNextLine equals: {  14 . 14 . 15 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: ''.
	
	^ anIterator
]

{ #category : 'examples - next line' }
BlCollectionRopeIteratorExamples >> nextLineWithLf_15 [
	<gtExample>
	| anIterator aNextLine |
	
	anIterator := self nextLineWithLf_14.
	aNextLine := anIterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aDelimitedEnd |
		{ aLineStart . aLineEnd . aDelimitedEnd } ].
	
	self assert: anIterator position equals: 21.
	self assert: aNextLine equals: {  15 . 21 . 21 }.
	self assert: (anIterator rope from: aNextLine first to: aNextLine second) asString equals: 'Line 4'.
	
	^ anIterator
]

{ #category : 'examples - next segment' }
BlCollectionRopeIteratorExamples >> nextSegmentWithLookAhead_at_0 [
	<gtExample>
	| anIterator aSegmentResult |
	
	anIterator := self small.
	
	aSegmentResult := anIterator
		nextSegment: [ :aBuffer | aBuffer first = aBuffer second ]
		indicesDo: [ :aFromIndex :aToIndex :anInitialValue :aFinalValue | { 
			aFromIndex . aToIndex . anInitialValue . aFinalValue
		} ]
		lookahead: 3.

	self assert: aSegmentResult equals: {  0 . 2 . false . true }.
	self assert: (anIterator rope from: aSegmentResult first to: aSegmentResult second) asString equals: 'He'.

	^ anIterator
]

{ #category : 'examples - next segment' }
BlCollectionRopeIteratorExamples >> nextSegmentWithLookAhead_at_3 [
	<gtExample>
	| anIterator aSegmentResult |
	
	anIterator := self nextSegmentWithLookAhead_at_0.
	
	aSegmentResult := anIterator
		nextSegment: [ :aBuffer | aBuffer first = aBuffer second ]
		indicesDo: [ :aFromIndex :aToIndex :anInitialValue :aFinalValue | { 
			aFromIndex . aToIndex . anInitialValue . aFinalValue
		} ]
		lookahead: 3.

	self assert: aSegmentResult equals: {  2 . 3 . true . false }.
	self assert: (anIterator rope from: aSegmentResult first to: aSegmentResult second) asString equals: 'l'.

	^ anIterator
]

{ #category : 'examples - next segment' }
BlCollectionRopeIteratorExamples >> nextSegmentWithLookAhead_at_5 [
	<gtExample>
	| anIterator aSegmentResult |
	
	anIterator := self nextSegmentWithLookAhead_at_3.
	
	aSegmentResult := anIterator
		nextSegment: [ :aBuffer | aBuffer first = aBuffer second ]
		indicesDo: [ :aFromIndex :aToIndex :anInitialValue :aFinalValue | { 
			aFromIndex . aToIndex . anInitialValue . aFinalValue
		} ]
		lookahead: 3.

	self assert: aSegmentResult equals: {  3 . 5 . false . false }.
	self assert: (anIterator rope from: aSegmentResult first to: aSegmentResult second) asString equals: 'lo'.

	^ anIterator
]

{ #category : 'instance creation' }
BlCollectionRopeIteratorExamples >> small [
	<gtExample>
	| anIterator |

	anIterator := BlCollectionRopeExamples new small iterator: 0 to: 5.
	
	self assert: anIterator position equals: 0.
	self assert: anIterator start equals: 0.
	self assert: anIterator end equals: 5.
	
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.
	
	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_0 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'Hello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_1 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_0.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_2 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_1.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'llo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_3 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_2.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'lo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_4 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_3.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'o'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_5 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_4.
	
	anError := nil.
	[ anIterator nextSpan ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_0 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small.
	
	anItem := anIterator next.
	
	self assert: anItem equals: $H.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_1 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_0.
	
	anItem := anIterator next.
	
	self assert: anItem equals: $e.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_2 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_1.
	
	anItem := anIterator next.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_3 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_2.
	
	anItem := anIterator next.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_4 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_3.
	
	anItem := anIterator next.
	
	self assert: anItem equals: $o.
	self assert: anIterator position equals: 5.
	self assert: anIterator hasNext not.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_next_at_5 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_4.
	
	anError := nil.
	[ anIterator next ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_0 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_1 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_0.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $e.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_2 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_1.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_3 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_2.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_4 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_3.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $o.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_peek_at_5 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_4.
	
	anError := nil.
	[ anIterator peek ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_0 [
	<gtExample>
	<label: 'Iterator throws an error when the start is reached'>
	| anIterator anError |
	
	anIterator := self small.
	
	anError := nil.
	[ anIterator previous ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_1 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_0.
	
	anItem := anIterator previous.
	
	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_2 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_1.

	anItem := anIterator previous.
	
	self assert: anItem equals: $e.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_3 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_2.

	anItem := anIterator previous.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_4 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_3.

	anItem := anIterator previous.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_previous_at_5 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_4.

	anItem := anIterator previous.
	
	self assert: anItem equals: $o.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_0_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 0.

	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_1_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 1.

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_2_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 2.

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_3_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 3.

	self assert: anIterator position equals: 3.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_4_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 4.

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_5_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 5.

	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_6_at_0 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small.
	
	anError := nil.
	[ anIterator skip: 6 ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]
