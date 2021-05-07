Class {
	#name : #BlCollectionRopeIteratorExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'instance creation' }
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

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_0 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'Hello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_1 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_0.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'ello'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_2 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_1.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'llo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_3 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_2.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'lo'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_nextSpan_at_4 [
	<gtExample>
	| anIterator aSpan |
	
	anIterator := self small_next_at_3.
	aSpan := anIterator nextSpan.
	
	self assert: aSpan collection equals: 'o'.
	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
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

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_0_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 0.

	self assert: anIterator position equals: 0.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_1_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 1.

	self assert: anIterator position equals: 1.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_2_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 2.

	self assert: anIterator position equals: 2.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_3_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 3.

	self assert: anIterator position equals: 3.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_4_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 4.

	self assert: anIterator position equals: 4.

	^ anIterator
]

{ #category : #'examples - enumeration' }
BlCollectionRopeIteratorExamples >> small_skip_5_at_0 [
	<gtExample>
	| anIterator |
	
	anIterator := self small.
	anIterator skip: 5.

	self assert: anIterator position equals: 5.

	^ anIterator
]

{ #category : #'examples - enumeration' }
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
