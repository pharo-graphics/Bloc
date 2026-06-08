"
I have been automatically converted and probably manually tweaked from BlConcatenationRopeIteratorExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlConcatenationRopeIteratorTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #metadata }
BlConcatenationRopeIteratorTest >> originClassName [
	"This test was generated from..."

	^ 'BlConcatenationRopeIteratorExamples'
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmall [

	| aRope anIterator |
	aRope := BlConcatenationRopeTest new testAttributesSmall5To10.
	anIterator := aRope iterator: 0 to: 10.

	self assert: anIterator position equals: 0.
	self assert: anIterator start equals: 0.
	self assert: anIterator end equals: 10.
	self assert: anIterator rope identicalTo: aRope.

	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.
	self assert: anIterator currentIterator rope identicalTo: aRope left.
	self assert: anIterator currentIterator position equals: 0.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt0 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 0.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 0.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt1 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 1.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 1.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt10 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 10.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt2 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 2.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 2.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt3 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 3.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 3.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt4 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 4.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 4.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt5 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 5.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt6 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 6.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 1.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt7 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 7.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 2.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt8 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 8.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 3.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallBackwardIteratorAt9 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator backwardIteratorAt: 9.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 4.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt0 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 0.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt1 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 1.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 1.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt10 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 10.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 5.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt2 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 2.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 2.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt3 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 3.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 3.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt4 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 4.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 4.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt5 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 5.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt6 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 6.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 1.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt7 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 7.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 2.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt8 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 8.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 3.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallForwardIteratorAt9 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmall.
	aSubIterator := anIterator forwardIteratorAt: 9.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 4.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt0 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmall.

	anItem := anIterator next.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt1 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt0.

	anItem := anIterator next.

	self assert: anItem equals: $e.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt10 [

	<sampleInstance>
	"Iterator throws an error when the end is reached"
	| anIterator anError |
	anIterator := self testSmallNextAt9.

	anError := nil.
	[ anIterator next ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt2 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt1.

	anItem := anIterator next.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt3 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt2.

	anItem := anIterator next.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt4 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt3.

	anItem := anIterator next.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 5.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt5 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt4.

	anItem := anIterator next.

	self assert: anItem equals: $W.
	self assert: anIterator position equals: 6.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt6 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt5.

	anItem := anIterator next.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 7.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt7 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt6.

	anItem := anIterator next.

	self assert: anItem equals: $r.
	self assert: anIterator position equals: 8.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt8 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt7.

	anItem := anIterator next.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 9.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextAt9 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt8.

	anItem := anIterator next.

	self assert: anItem equals: $d.
	self assert: anIterator position equals: 10.
	self assert: anIterator hasNext not.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 5.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt0 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmall.
	aSpan := anIterator nextSpan.

	self assert: aSpan == anIterator rope left.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt1 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt0.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt10 [

	<sampleInstance>
	"Iterator throws an error when the end is reached"
	| anIterator anError |
	anIterator := self testSmallNextAt9.

	anError := nil.
	[ anIterator nextSpan ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt2 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt1.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'llo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt3 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt2.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'lo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt4 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt3.
	aSpan := anIterator nextSpan.

	self assert: aSpan collection equals: 'o'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt5 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt4.
	aSpan := anIterator nextSpan.

	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'World'.
	self assert: aSpan == anIterator rope right.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt6 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt5.
	aSpan := anIterator nextSpan.

	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'orld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt7 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt6.
	aSpan := anIterator nextSpan.

	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'rld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt8 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt7.
	aSpan := anIterator nextSpan.

	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'ld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallNextSpanAt9 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallNextAt8.
	aSpan := anIterator nextSpan.

	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'd'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt0 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmall.

	anItem := anIterator peek.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt1 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt0.

	anItem := anIterator peek.

	self assert: anItem equals: $e.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt10 [

	<sampleInstance>
	"Iterator throws an error when the end is reached"
	| anIterator anError |
	anIterator := self testSmallNextAt9.

	anError := nil.
	[ anIterator peek ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt2 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt1.

	anItem := anIterator peek.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt3 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt2.

	anItem := anIterator peek.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt4 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt3.

	anItem := anIterator peek.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt5 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt4.

	anItem := anIterator peek.

	self assert: anItem equals: $W.
	self assert: anIterator position equals: 5.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt6 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt5.

	anItem := anIterator peek.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 6.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt7 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt6.

	anItem := anIterator peek.

	self assert: anItem equals: $r.
	self assert: anIterator position equals: 7.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt8 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt7.

	anItem := anIterator peek.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 8.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPeekAt9 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt8.

	anItem := anIterator peek.

	self assert: anItem equals: $d.
	self assert: anIterator position equals: 9.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt0 [

	<sampleInstance>
	"Iterator throws an error when the start is reached"
	| anIterator anError |
	anIterator := self testSmall.

	anError := nil.
	[ anIterator previous ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt1 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt0.

	anItem := anIterator previous.

	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 0.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt10 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt9.

	anItem := anIterator previous.

	self assert: anItem equals: $d.
	self assert: anIterator position equals: 9.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt2 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt1.

	anItem := anIterator previous.

	self assert: anItem equals: $e.
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt3 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt2.

	anItem := anIterator previous.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 2.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt4 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt3.

	anItem := anIterator previous.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 3.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt5 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt4.

	anItem := anIterator previous.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 4.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt6 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt5.

	anItem := anIterator previous.

	self assert: anItem equals: $W.
	self assert: anIterator position equals: 5.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 5.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt7 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt6.

	anItem := anIterator previous.

	self assert: anItem equals: $o.
	self assert: anIterator position equals: 6.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt8 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt7.

	anItem := anIterator previous.

	self assert: anItem equals: $r.
	self assert: anIterator position equals: 7.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallPreviousAt9 [

	<sampleInstance>
	| anIterator anItem |
	anIterator := self testSmallNextAt8.

	anItem := anIterator previous.

	self assert: anItem equals: $l.
	self assert: anIterator position equals: 8.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip0At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 0.

	self assert: anIterator position equals: 0.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip10At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 10.

	self assert: anIterator position equals: 10.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 5.

	"we skip by more than 5 therefore the algorithm creates a new sub-iterator"
	self assert: anIterator currentIterator start equals: 5.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip11At0 [

	<sampleInstance>
	"Iterator throws an error when the end is reached"
	| anIterator anError |
	anIterator := self testSmall.

	anError := nil.
	[ anIterator skip: 11 ]
		on: Error
		do: [ :e | anError := e ].

	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip1At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 1.

	self assert: anIterator position equals: 1.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip2At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 2.

	self assert: anIterator position equals: 2.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip3At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 3.

	self assert: anIterator position equals: 3.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip4At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 4.

	self assert: anIterator position equals: 4.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip5At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 5.

	self assert: anIterator position equals: 5.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip6At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 6.

	self assert: anIterator position equals: 6.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 1.

	"we skip by more than 5 therefore the algorithm creates a new sub-iterator"
	self assert: anIterator currentIterator start equals: 1.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip7At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 7.

	self assert: anIterator position equals: 7.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 2.

	"we skip by more than 5 therefore the algorithm creates a new sub-iterator"
	self assert: anIterator currentIterator start equals: 2.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip8At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 8.

	self assert: anIterator position equals: 8.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 3.

	"we skip by more than 5 therefore the algorithm creates a new sub-iterator"
	self assert: anIterator currentIterator start equals: 3.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallSkip9At0 [

	<sampleInstance>
	| anIterator |
	anIterator := self testSmall.
	anIterator skip: 9.

	self assert: anIterator position equals: 9.

	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 4.

	"we skip by more than 5 therefore the algorithm creates a new sub-iterator"
	self assert: anIterator currentIterator start equals: 4.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTree [

	<sampleInstance>
	| aRope anIterator aCollectionRope |
	aCollectionRope := BlCollectionRope collection: 'EarthHelloWorld'.

	aRope := BlConcatenationRope
		         left: (BlSubRope rope: aCollectionRope offset: 0 length: 5)
		         right: (BlConcatenationRope
				          left: (BlAttributeRope
						           attributes: { 0 }
						           rope:
						           (BlSubRope rope: aCollectionRope offset: 5 length: 5))
				          right:
				          (BlSubRope rope: aCollectionRope offset: 10 length: 5)).


	anIterator := aRope iterator: 0 to: 15.

	self assert: anIterator position equals: 0.
	self assert: anIterator start equals: 0.
	self assert: anIterator end equals: 15.
	self assert: anIterator rope == aRope.

	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.

	self assert: anIterator currentIterator rope == aCollectionRope.
	self assert: anIterator currentIterator position equals: 0.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt0 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 0.

	self assert: aSubIterator rope == anIterator rope left rope.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt1 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 1.

	self assert: aSubIterator rope == anIterator rope left rope.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 1.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt10 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 10.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 10.
	self assert: aSubIterator start equals: 10.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt11 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 11.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 11.
	self assert: aSubIterator start equals: 11.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt12 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 12.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 12.
	self assert: aSubIterator start equals: 12.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt13 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 13.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 13.
	self assert: aSubIterator start equals: 13.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt14 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 14.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 14.
	self assert: aSubIterator start equals: 14.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt15 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 15.

	self assert: aSubIterator rope == anIterator rope right right rope.
	self assert: aSubIterator position equals: 15.
	self assert: aSubIterator start equals: 15.
	self assert: aSubIterator end equals: 15.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt2 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 2.

	self assert: aSubIterator rope == anIterator rope left rope.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 2.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt3 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 3.

	self assert: aSubIterator rope == anIterator rope left rope.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 3.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt4 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 4.

	self assert: aSubIterator rope == anIterator rope left rope.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 4.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt5 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 5.

	self assert: aSubIterator rope == anIterator rope right left.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt6 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 6.

	self assert: aSubIterator rope == anIterator rope right left.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 1.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt7 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 7.

	self assert: aSubIterator rope == anIterator rope right left.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 2.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt8 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 8.

	self assert: aSubIterator rope == anIterator rope right left.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 3.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeForwardIteratorAt9 [

	<sampleInstance>
	| anIterator aSubIterator |
	anIterator := self testSmallTree.
	aSubIterator := anIterator forwardIteratorAt: 9.

	self assert: aSubIterator rope == anIterator rope right left.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 4.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeNextSpanAt0 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallTree.

	aSpan := anIterator nextSpan.

	self assert: aSpan isScoped.
	self assert: aSpan == anIterator rope left.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeNextSpanAt10 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallTreeNextSpanAt5.

	aSpan := anIterator nextSpan.

	self assert: aSpan == anIterator rope right right.
	self assert: anIterator position equals: 15.

	^ anIterator
]

{ #category : #tests }
BlConcatenationRopeIteratorTest >> testSmallTreeNextSpanAt5 [

	<sampleInstance>
	| anIterator aSpan |
	anIterator := self testSmallTreeNextSpanAt0.

	aSpan := anIterator nextSpan.

	self assert: aSpan == anIterator rope right left.
	self assert: anIterator position equals: 10.

	^ anIterator
]
