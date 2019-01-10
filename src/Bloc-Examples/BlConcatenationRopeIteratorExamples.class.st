Class {
	#name : #BlConcatenationRopeIteratorExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'instance creation' }
BlConcatenationRopeIteratorExamples >> small [
	<gtExample>
	| aRope anIterator |
	
	aRope := BlConcatenationRopeExamples new attributes_small_5_to_10.
	anIterator := aRope iterator: 0 to: 10.
	
	self assert: anIterator position equals: 0.
	self assert: anIterator start equals: 0.
	self assert: anIterator end equals: 10.
	self assert: anIterator rope == aRope.
	
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.
	
	self assert: anIterator currentIterator rope == aRope left.
	self assert: anIterator currentIterator position equals: 0.
	
	^ anIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_0 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.
	aSubIterator := anIterator backwardIteratorAt: 0.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_1 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.
	aSubIterator := anIterator backwardIteratorAt: 1.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_10 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 10.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_2 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 2.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_3 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 3.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_4 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 4.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_5 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 5.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_6 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 6.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_7 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 7.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_8 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 8.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_backward_iterator_at_9 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator backwardIteratorAt: 9.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_0 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 0.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_1 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 1.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_10 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 10.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 5.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_2 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 2.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_3 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 3.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_4 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 4.

	self assert: aSubIterator rope == anIterator rope left.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_5 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 5.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 0.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_6 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 6.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 1.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_7 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 7.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 2.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_8 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 8.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 3.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - utility' }
BlConcatenationRopeIteratorExamples >> small_forward_iterator_at_9 [
	<gtExample>
	| anIterator aSubIterator |
	
	anIterator := self small.	
	aSubIterator := anIterator forwardIteratorAt: 9.

	self assert: aSubIterator rope == anIterator rope right.
	self assert: aSubIterator position equals: 4.
	self assert: aSubIterator start equals: 0.
	self assert: aSubIterator end equals: 5.

	^ aSubIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_0 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'Hello'.
	self assert: anIterator position equals: 5.
	self assert: aSpan == anIterator rope left.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_1 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_0.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_10 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_9.
	
	anError := nil.
	[ anIterator nextSpan ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_2 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_1.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'llo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_3 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_2.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'lo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_4 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_3.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'o'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_5 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_4.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'World'.
	self assert: aSpan == anIterator rope right.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_6 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_5.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'orld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_7 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_6.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'rld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_8 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_7.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'ld'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_nextSpan_at_9 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_8.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan attributes equals: { 1 }.
	self assert: aSpan rope collection equals: 'd'.
	self assert: anIterator position equals: 10.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_0 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_1 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_0.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_10 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_9.
	
	anError := nil.
	[ anIterator next ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_2 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_1.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_3 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_2.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_4 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_3.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_5 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_4.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_6 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_5.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_7 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_6.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_8 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_7.
	
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_next_at_9 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_8.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_0 [
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_1 [
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_10 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small_next_at_9.
	
	anError := nil.
	[ anIterator peek ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_2 [
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_3 [
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_4 [
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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_5 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_4.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $W.
	self assert: anIterator position equals: 5.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_6 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_5.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $o.
	self assert: anIterator position equals: 6.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_7 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_6.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $r.
	self assert: anIterator position equals: 7.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_8 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_7.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $l.
	self assert: anIterator position equals: 8.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_peek_at_9 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_8.
	
	anItem := anIterator peek.
	
	self assert: anItem equals: $d.
	self assert: anIterator position equals: 9.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_0 [
	<gtExample>
	<label: 'Iterator throws an error when the start is reached'>
	| anIterator anError |
	
	anIterator := self small.
	
	anError := nil.
	[ anIterator previous ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_1 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_0.
	
	anItem := anIterator previous.
	
	self assert: anItem equals: $H.
	self assert: anIterator position equals: 0.
	self assert: anIterator hasNext.
	self assert: anIterator hasPrevious not.
	
	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_10 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_9.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_2 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_1.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_3 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_2.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_4 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_3.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_5 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_4.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_6 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_5.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_7 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_6.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_8 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_7.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_previous_at_9 [
	<gtExample>
	| anIterator anItem |
	
	anIterator := self small_next_at_8.

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

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_0_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 0.

	self assert: anIterator position equals: 0.
	
	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_10_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 10.

	self assert: anIterator position equals: 10.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 5.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_11_at_0 [
	<gtExample>
	<label: 'Iterator throws an error when the end is reached'>
	| anIterator anError |
	
	anIterator := self small.
	
	anError := nil.
	[ anIterator skip: 11 ] on: Error do: [ :e | anError := e ].
	
	self assert: anError isNotNil.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_1_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 1.

	self assert: anIterator position equals: 1.
	
	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_2_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 2.

	self assert: anIterator position equals: 2.

	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_3_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 3.

	self assert: anIterator position equals: 3.
	
	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_4_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 4.

	self assert: anIterator position equals: 4.
	
	self assert: anIterator currentIterator rope == anIterator rope left.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_5_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 5.

	self assert: anIterator position equals: 5.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 0.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_6_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 6.

	self assert: anIterator position equals: 6.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 1.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_7_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 7.

	self assert: anIterator position equals: 7.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 2.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_8_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 8.

	self assert: anIterator position equals: 8.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 3.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeIteratorExamples >> small_skip_9_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 9.

	self assert: anIterator position equals: 9.
	
	self assert: anIterator currentIterator rope == anIterator rope right.
	self assert: anIterator currentIterator position equals: 4.
	self assert: anIterator currentIterator start equals: 0.
	self assert: anIterator currentIterator end equals: 5.

	^ anIterator
]
