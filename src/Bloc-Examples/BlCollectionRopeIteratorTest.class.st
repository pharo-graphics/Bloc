"
I have been automatically converted and probably manually tweaked from BlCollectionRopeIteratorExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlCollectionRopeIteratorTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #running }
BlCollectionRopeIteratorTest >> newHelloIterator [

	^ (BlCollectionRope collection: 'Hello') iterator: 0 to: 5
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testInitialState [

	| anIterator |
	anIterator := self newHelloIterator.

	self assert: anIterator position equals: 0.
	self assert: anIterator start equals: 0.
	self assert: anIterator end equals: 5.

	self assert: anIterator hasNext.
	self deny: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextAt0 [

	| anIterator anItem |
	anIterator := self newHelloIterator.

	anItem := anIterator next.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextAt1 [

	| anIterator anItem |
	anIterator := self newHelloIterator.
	anIterator next.

	anItem := anIterator next.

	self assert: anItem equals: $e.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextAt4 [

	| anIterator anItem |
	anIterator := self newHelloIterator.
	4 timesRepeat: [ anIterator next ].

	anItem := anIterator next.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 5.
	self deny: anIterator hasNext.
	self assert: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextAt5 [
	"Iterator throws an error when the end is reached"

	| anIterator |
	anIterator := self newHelloIterator.
	5 timesRepeat: [ anIterator next ].

	self should: [ anIterator next ] raise: Error
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf0 [

	| aString anIterator aNextLine |
	aString := 'Line 1', String crlf, 'Line 2', String crlf, String crlf, 'Line 4'.
	anIterator := (BlCollectionRope collection: aString) iterator.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf08 [

	| anIterator aNextLine |
	anIterator := self testNextLineIndicesWithCrlf0.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf16 [

	| anIterator aNextLine |
	anIterator := self testNextLineIndicesWithCrlf08.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineIndicesWithCrlf18 [

	| anIterator aNextLine |
	anIterator := self testNextLineIndicesWithCrlf16.

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
			(anIterator rope
				from: aNextLine first
				to: aNextLine second) asString
		equals: 'Line 4'
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithCr0 [

	| aString anIterator aNextLine |
	aString := 'Line 1', String cr, 'Line 2', String cr, String cr, 'Line 4'.
	anIterator := (BlCollectionRope collection: aString) iterator.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithCr07 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithCr0.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithCr14 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithCr07.
	
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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithCr15 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithCr14.
	
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
		equals: 'Line 4'
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithCrlf [

	| aString anIterator |
	aString := 'Line 1', String crlf, 'Line 2', String crlf, String crlf, 'Line 4'.
	anIterator := (BlCollectionRope collection: aString) iterator.

	self assert: anIterator nextLine asString equals: 'Line 1'.
	self assert: anIterator nextLine asString equals: 'Line 2'.
	self assert: anIterator nextLine asString equals: ''.
	self assert: anIterator nextLine asString equals: 'Line 4'
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithLf0 [

	| aString anIterator aNextLine |
	aString := 'Line 1', String lf, 'Line 2', String lf, String lf, 'Line 4'.
	anIterator := (BlCollectionRope collection: aString) iterator.

	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {  aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 7.
	self assert: aNextLine equals: { 0. 6. 7 }.
	self
		assert:
			(anIterator rope
				from: aNextLine first
				to: aNextLine second) asString
		equals: 'Line 1'.

	^ anIterator
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithLf07 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithLf0.
	
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {  aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 14.
	self assert: aNextLine equals: { 7. 13. 14 }.
	self
		assert:
			(anIterator rope
				from: aNextLine first
				to: aNextLine second) asString
		equals: 'Line 2'.

	^ anIterator
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithLf14 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithLf07.
	
	aNextLine := anIterator nextLineIndicesDo: [
		             :aLineStart
		             :aLineEnd
		             :aDelimitedEnd |
		             {  aLineStart.
			             aLineEnd.
			             aDelimitedEnd } ].

	self assert: anIterator position equals: 15.
	self assert: aNextLine equals: { 14. 14. 15 }.
	self
		assert:
			(anIterator rope
				from: aNextLine first
				to: aNextLine second) asString
		equals: ''.

	^ anIterator
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextLineWithLf15 [

	| anIterator aNextLine |
	anIterator := self testNextLineWithLf14.
	
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
			(anIterator rope
				from: aNextLine first
				to: aNextLine second) asString
		equals: 'Line 4'
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt0 [

	| anIterator aSegmentResult |
	anIterator := self newHelloIterator.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt3 [

	| anIterator aSegmentResult |
	anIterator := self testNextSegmentWithLookAheadAt0.

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

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSegmentWithLookAheadAt5 [

	| anIterator aSegmentResult |
	anIterator := self testNextSegmentWithLookAheadAt3.

	aSegmentResult := anIterator
		                  nextSegment: [ :aBuffer |
			                  aBuffer first = aBuffer second ]
		                  indicesDo: [
			                  :aFromIndex
			                  :aToIndex
			                  :anInitialValue
			                  :aFinalValue |
			                  {	aFromIndex.
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
		equals: 'lo'
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSpanAt0 [

	| anIterator aSpan |
	anIterator := self newHelloIterator.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'Hello'.
	self assert: anIterator position equals: 5
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSpanAt1 [

	| anIterator aSpan |
	anIterator := self newHelloIterator.
	anIterator next.

	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testNextSpanAt5 [
	"Iterator throws an error when the end is reached"

	| anIterator |
	anIterator := self newHelloIterator.
	5 timesRepeat: [ anIterator next ].

	self should: [ anIterator nextSpan ] raise: Error
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPeekAt0 [

	| anIterator anItem |
	anIterator := self newHelloIterator.

	anItem := anIterator peek.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self deny: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPeekAt4 [

	| anIterator anItem |
	anIterator := self newHelloIterator.
	4 timesRepeat: [ anIterator next ].

	anItem := anIterator peek.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPeekAt5 [
	"Iterator throws an error when the end is reached"

	| anIterator |
	anIterator := self newHelloIterator.
	5 timesRepeat: [ anIterator next ].

	self should: [ anIterator peek ] raise: Error
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPreviousAt0RaisesError [
	"Iterator throws an error when the start is reached"

	| anIterator |
	anIterator := self newHelloIterator.

	self should: [ anIterator previous ] raise: Error
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPreviousFrom1To0 [

	| anIterator anItem |
	anIterator := self newHelloIterator.
	anIterator next.

	anItem := anIterator previous.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self deny: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPreviousFrom2To1 [

	| anIterator anItem |
	anIterator := self newHelloIterator.
	2 timesRepeat: [ anIterator next ].

	self assert: anIterator position equals: 2.

	anItem := anIterator previous.

	self assert: anItem equals: $e.
	self assert: anIterator position equals: 1.

]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testPreviousFrom5To0 [

	| anIterator |
	anIterator := self newHelloIterator.
	5 timesRepeat: [ anIterator next ].

	self assert: anIterator position equals: 5.
	self deny: anIterator hasNext.
	self assert: anIterator hasPrevious.
	
	self assert: anIterator previous equals: $o.
	self assert: anIterator previous equals: $l.
	self assert: anIterator previous equals: $l.
	self assert: anIterator previous equals: $e.
	self assert: anIterator previous equals: $H.

	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self deny: anIterator hasPrevious
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testSkip [

	| anIterator |
	anIterator := self newHelloIterator.

	anIterator skip: 1.

	self assert: anIterator position equals: 1.

	anIterator skip: 3.

	self assert: anIterator position equals: 4.

	anIterator skip: 1.

	self assert: anIterator position equals: 5
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testSkipOutOfBoundsRaisesError [

	| anIterator |
	anIterator := self newHelloIterator.

	self should: [ anIterator skip: 6 ] raise: Error.

	anIterator skip: 4.

	self should: [ anIterator skip: 2 ] raise: Error.

	anIterator skip: 1
]

{ #category : #tests }
BlCollectionRopeIteratorTest >> testSkipZeroDoesntChangePosition [

	| anIterator |
	anIterator := self newHelloIterator.
	anIterator next.
	self assert: anIterator position equals: 1.
	
	anIterator skip: 0.

	self assert: anIterator position equals: 1
]
