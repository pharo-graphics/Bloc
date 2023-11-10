"
I contain examples of a collection rope

"
Class {
	#name : #BlCollectionRopeExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_empty_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self testSmall_empty.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope isNotEmpty.
	self assert: anAttributedRope attributes equals: { 1 }.
	self assert: anAttributedRope rope == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope asString equals: ''.

	self assert: anAttributedRope right == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_0_to_1 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope asString equals: 'H'.

	self assert: anAttributedRope right asString equals: 'ello'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_0_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope rope == aRope.
	self assert: anAttributedRope attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_2_to_2 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left asString equals: 'He'.

	self assert: anAttributedRope right left rope asString equals: ''.
	self assert: anAttributedRope right left attributes equals: { 1 }.

	self assert: anAttributedRope right right asString equals: 'llo'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_4_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left asString equals: 'Hell'.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope asString equals: 'o'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testAttributes_small_5_to_5 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 5.

	self assert: anAttributedRope left asString equals: 'Hello'.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope asString equals: ''.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamplesTest >> testClear_attributes_empty_0_to_0 [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self testSmall_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes
]

{ #category : #'instance creation' }
BlCollectionRopeExamplesTest >> testSmall [
	<gtExample>
	"Creates an instance of the rope of size smaller than combineLength"
	| aRope |

	aRope := BlCollectionRope collection: 'Hello'.

	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope collection equals: 'Hello'.
	self assert: aRope isLeaf.
	self assert: aRope size <= BlRope combineLength.

	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamplesTest >> testSmall_at_each [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: (aRope at: 1) equals: $H.
	self assert: (aRope at: 2) equals: $e.
	self assert: (aRope at: 3) equals: $l.
	self assert: (aRope at: 4) equals: $l.
	self assert: (aRope at: 5) equals: $o.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamplesTest >> testSmall_children [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope children equals: { }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 0.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_1_to_3 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 3.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope asString equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_4_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamplesTest >> testSmall_delete_5_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamplesTest >> testSmall_depth [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlCollectionRopeExamplesTest >> testSmall_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self testSmall.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty asString equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_0_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 0 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_0_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'e'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_2_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 2 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_1_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamplesTest >> testSmall_from_3_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self testSmall.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope asString equals: 'lo'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamplesTest >> testSmall_from_3_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream | aRope from: 3 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 0.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: '123Hello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 1.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'H123ello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_2 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 2.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'He123llo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_3 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 3.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hel123lo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_4 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 4.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hell123o'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_rope_123_at_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 5.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hello123'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 0.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: '123Hello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 1.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'H123ello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_2 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 2.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'He123llo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_3 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 3.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hel123lo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_4 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 4.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hell123o'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamplesTest >> testSmall_insert_string_123_at_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope insertItems: '123' at: 5.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hello123'.

	^ aNewRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamplesTest >> testSmall_isEmpty [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamplesTest >> testSmall_isLeaf [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope isLeaf.

	^ aRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamplesTest >> testSmall_isNotEmpty [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamplesTest >> testSmall_size [
	<gtExample>
	| aRope |
	
	aRope := self testSmall.

	self assert: aRope size equals: 5.

	^ aRope
]
