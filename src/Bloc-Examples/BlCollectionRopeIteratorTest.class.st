"
I have been automatically converted and probably manually tweaked from BlCollectionRopeIteratorExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : 'BlCollectionRopeIteratorTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Examples',
	#package : 'Bloc-Examples'
}

{ #category : 'fixture' }
BlCollectionRopeIteratorTest >> NextLineWithCr0 [

	<sampleInstance>
	| anIterator aNextLine |
	anIterator := (BlCollectionRope collection:
		               'Line 1' , String cr , 'Line 2' , String cr
		               , String cr , 'Line 4') iterator.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 7.
	self assert: aNextLine equals: { 0. 6. 7 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 1'.

	^ anIterator
]

{ #category : 'metadata' }
BlCollectionRopeIteratorTest >> originClassName [
	"This test was generated from..."
	^ 'BlCollectionRopeIteratorExamples'
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf0 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := (BlCollectionRope collection:
		               'Line 1' , String crlf , 'Line 2' , String crlf
		               , String crlf , 'Line 4') iterator.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 8.
	self assert: aNextLine equals: { 0. 6. 8 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 1'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf08 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineIndicesWithCrlf_0.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 16.
	self assert: aNextLine equals: { 8. 14. 16 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 2'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf16 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineIndicesWithCrlf_08.

	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 18.
	self assert: aNextLine equals: { 16. 16. 18 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: ''.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf18 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineIndicesWithCrlf_16.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 24.
	self assert: aNextLine equals: { 18. 24. 24 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 4'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithCr07 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithCr_0.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 14.
	self assert: aNextLine equals: { 7. 13. 14 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 2'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithCr14 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithCr_07.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 15.
	self assert: aNextLine equals: { 14. 14. 15 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: ''.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithCr15 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithCr_14.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 21.
	self assert: aNextLine equals: { 15. 21. 21 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 4'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithCrlf [

	<gtExample>
	| anIterator |
	anIterator := (BlCollectionRope collection:
		               'Line 1' , String crlf , 'Line 2' , String crlf
		               , String crlf , 'Line 4') iterator.

	self assert: anIterator nextLine asString equals: 'Line 1'.
	self assert: anIterator nextLine asString equals: 'Line 2'.
	self assert: anIterator nextLine asString equals: ''.
	self assert: anIterator nextLine asString equals: 'Line 4'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithLf0 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := (BlCollectionRope collection:
		               'Line 1' , String lf , 'Line 2' , String lf
		               , String lf , 'Line 4') iterator.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 7.
	self assert: aNextLine equals: { 0. 6. 7 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 1'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithLf07 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithLf_0.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 14.
	self assert: aNextLine equals: { 7. 13. 14 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 2'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithLf14 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithLf_07.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 15.
	self assert: aNextLine equals: { 14. 14. 15 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: ''.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextLineWithLf15 [

	<gtExample>
	| anIterator aNextLine |
	anIterator := self nextLineWithLf_14.
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {
			             aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 21.
	self assert: aNextLine equals: { 15. 21. 21 }.
	self
		assert:
		(anIterator rope from: aNextLine first to: aNextLine second)
			asString
		equals: 'Line 4'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt0 [

	<gtExample>
	| anIterator aSegmentResult |
	anIterator := self small.

	aSegmentResult := anIterator
		                  nextSegment: [ :aBuffer |
		                  aBuffer first = aBuffer second ]
		                  indicesDo: [
			                  :aFromIndex
			                  :aToIndex
			                  :anInitialValue
			                  :aFinalValue |
			                  {
				                  aFromIndex.
				                  aToIndex.
				                  anInitialValue.
				                  aFinalValue } ]
		                  lookahead: 3.

	self assert: aSegmentResult equals: { 0. 2. false. true }.
	self
		assert:
			(anIterator rope
				 from: aSegmentResult first
				 to: aSegmentResult second) asString
		equals: 'He'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt3 [

	<gtExample>
	| anIterator aSegmentResult |
	anIterator := self nextSegmentWithLookAhead_at_0.

	aSegmentResult := anIterator
		                  nextSegment: [ :aBuffer |
		                  aBuffer first = aBuffer second ]
		                  indicesDo: [
			                  :aFromIndex
			                  :aToIndex
			                  :anInitialValue
			                  :aFinalValue |
			                  {
				                  aFromIndex.
				                  aToIndex.
				                  anInitialValue.
				                  aFinalValue } ]
		                  lookahead: 3.

	self assert: aSegmentResult equals: { 2. 3. true. false }.
	self
		assert:
			(anIterator rope
				 from: aSegmentResult first
				 to: aSegmentResult second) asString
		equals: 'l'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt5 [

	<gtExample>
	| anIterator aSegmentResult |
	anIterator := self nextSegmentWithLookAhead_at_3.

	aSegmentResult := anIterator
		                  nextSegment: [ :aBuffer |
		                  aBuffer first = aBuffer second ]
		                  indicesDo: [
			                  :aFromIndex
			                  :aToIndex
			                  :anInitialValue
			                  :aFinalValue |
			                  {
				                  aFromIndex.
				                  aToIndex.
				                  anInitialValue.
				                  aFinalValue } ]
		                  lookahead: 3.

	self assert: aSegmentResult equals: { 3. 5. false. false }.
	self
		assert:
			(anIterator rope
				 from: aSegmentResult first
				 to: aSegmentResult second) asString
		equals: 'lo'.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmall [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt0 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt1 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt2 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt3 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt4 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextAt5 [

	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	anIterator := self small_next_at_4.

	anError := nil.
	[ anIterator next ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt0 [

	<gtExample>
	| anIterator aSpan |
	anIterator := self small.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'Hello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt1 [

	<gtExample>
	| anIterator aSpan |
	anIterator := self small_next_at_0.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt2 [

	<gtExample>
	| anIterator aSpan |
	anIterator := self small_next_at_1.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'llo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt3 [

	<gtExample>
	| anIterator aSpan |
	anIterator := self small_next_at_2.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'lo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt4 [

	<gtExample>
	| anIterator aSpan |
	anIterator := self small_next_at_3.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'o'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallNextSpanAt5 [

	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	anIterator := self small_next_at_4.

	anError := nil.
	[ anIterator nextSpan ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt0 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt1 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt2 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt3 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt4 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPeekAt5 [

	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	anIterator := self small_next_at_4.

	anError := nil.
	[ anIterator peek ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt0 [

	<gtExample>
	<label: 'Iterator throws an error when the start is reached'>
	| anIterator anError |
	anIterator := self small.

	anError := nil.
	[ anIterator previous ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt1 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt2 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt3 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt4 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallPreviousAt5 [

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

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip0At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 0.

	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip1At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 1.

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip2At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 2.

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip3At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 3.

	self assert: anIterator position equals: 3.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip4At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 4.

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip5At0 [

	<gtExample>
	| anIterator |
	anIterator := self small.
	anIterator skip: 5.

	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : 'tests' }
BlCollectionRopeIteratorTest >> testSmallSkip6At0 [

	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	anIterator := self small.

	anError := nil.
	[ anIterator skip: 6 ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]
