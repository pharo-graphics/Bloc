"
I contain examples of an attribute rope

"
Class {
	#name : #BlAttributeRopeExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_empty_0_to_0 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall_empty.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope isNotEmpty.
	self assert: anAttributedRope attributes equals: { 0. 1 }.
	self assert: anAttributedRope rope == aRope rope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_0_to_0 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left attributes equals: { 0. 1 }.
	self assert: anAttributedRope left rope collection equals: ''.

	self assert: anAttributedRope right == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_0_to_1 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left attributes equals: { 0. 1 }.
	self assert: anAttributedRope left rope collection equals: 'H'.

	self assert: anAttributedRope right attributes equals: { 0 }.
	self assert: anAttributedRope right rope collection equals: 'ello'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_0_to_5 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope rope == aRope rope.
	self assert: anAttributedRope attributes equals: { 0. 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_2_to_2 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left rope collection equals: 'He'.
	self assert: anAttributedRope left attributes equals: { 0 }.

	self assert: anAttributedRope right left rope collection equals: ''.
	self assert: anAttributedRope right left attributes equals: { 0. 1 }.

	self
		assert: anAttributedRope right right rope collection
		equals: 'llo'.
	self assert: anAttributedRope right right attributes equals: { 0 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_4_to_5 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left attributes equals: { 0 }.
	self assert: anAttributedRope left rope collection equals: 'Hell'.

	self assert: anAttributedRope right attributes equals: { 0. 1 }.
	self assert: anAttributedRope right rope collection equals: 'o'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testAttributes_small_5_to_5 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 5.

	self assert: anAttributedRope left == aRope.

	self assert: anAttributedRope right attributes equals: { 0. 1 }.
	self assert: anAttributedRope right rope collection equals: ''.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testClear_attributes_empty_0_to_0 [

	<sampleInstance>
	| anEmptyRope aRopeWithoutAttributes |
	anEmptyRope := self testSmall_empty.

	"clearing attributes on the empty attributed rope actually completely removes attributes"
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes collection equals: ''.
	self assert: aRopeWithoutAttributes == anEmptyRope rope.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testClear_attributes_small_0_to_0 [

	<sampleInstance>
	| aRope aRopeWithoutAttributes |
	aRope := self testSmall.
	aRopeWithoutAttributes := aRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes == aRope.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamplesTest >> testClear_attributes_small_0_to_1 [

	<sampleInstance>
	| aRope aRopeWithoutAttributes |
	aRope := self testSmall.
	aRopeWithoutAttributes := aRope clearAttributes: 0 to: 1.

	self assert: aRopeWithoutAttributes left collection equals: 'H'.

	self assert: aRopeWithoutAttributes right attributes equals: { 0 }.
	self
		assert: aRopeWithoutAttributes right rope collection
		equals: 'ello'.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - utility' }
BlAttributeRopeExamplesTest >> testMergeAttributes [

	<sampleInstance>
	| firstDuplicate secondDuplicate theOriginalAttributes theAddedAttributes theAttributesWithoutDuplicates |
	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.

	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.

	theOriginalAttributes := {
		                         firstDuplicate.
		                         1.
		                         2 }.
	theAddedAttributes := {
		                      3.
		                      secondDuplicate }.

	theAttributesWithoutDuplicates := BlAttributeRope
		                                  mergeAttributes:
		                                  theOriginalAttributes
		                                  and: theAddedAttributes.

	self assert: theAttributesWithoutDuplicates equals: {
			secondDuplicate.
			1.
			2.
			3 }.

	^ theAttributesWithoutDuplicates
]

{ #category : #'examples - utility' }
BlAttributeRopeExamplesTest >> testRemoveDuplicates [

	<sampleInstance>
	| firstDuplicate secondDuplicate theOriginalAttributes theAttributesWithoutDuplicates |
	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.

	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.

	theOriginalAttributes := {
		                         firstDuplicate.
		                         1.
		                         2.
		                         3.
		                         secondDuplicate }.
	theAttributesWithoutDuplicates := BlAttributeRope removeDuplicates:
		                                  theOriginalAttributes.

	self assert: theAttributesWithoutDuplicates equals: {
			secondDuplicate.
			1.
			2.
			3 }.

	^ theAttributesWithoutDuplicates
]

{ #category : #'instance creation' }
BlAttributeRopeExamplesTest >> testSmall [
	"Creates an instance of the rope of size smaller than combineLength with one attribute applied on the whole rope"

	<sampleInstance>
	| aRope |
	aRope := BlAttributeRope
		         attributes: { 0 }
		         rope: (BlCollectionRope collection: 'Hello').

	"attribute rope does not increase depth because it is just a plain wrapper"
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope attributes equals: { 0 }.
	self assert: aRope rope collection equals: 'Hello'.
	self assert: aRope isLeaf not.
	self assert: aRope size <= BlRope combineLength.

	^ aRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamplesTest >> testSmall_at_each [

	<sampleInstance>
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
BlAttributeRopeExamplesTest >> testSmall_children [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope children equals: { aRope rope }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_0_to_0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_0_to_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 1.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'ello'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_0_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 5.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_1_to_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 1.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_1_to_3 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 3.

	self assert: aNewRope size equals: 3.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_1_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 5.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'H'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_4_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 5.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamplesTest >> testSmall_delete_5_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 5.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamplesTest >> testSmall_depth [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlAttributeRopeExamplesTest >> testSmall_empty [

	<sampleInstance>
	| aRope anEmpty |
	aRope := self testSmall.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	"is not actually empty, because it preserves the attributes of the original rope"
	self assert: anEmpty isNotEmpty.
	self assert: anEmpty attributes equals: { 0 }.
	self assert: anEmpty rope collection equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 0.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_0_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 0
			               to: 0
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 1.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'H'.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_1_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 0
			               to: 1
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 5.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_0_to_5_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 0
			               to: 5
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 1.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_1_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 1
			               to: 1
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_2 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 2.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'e'.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_2_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 1
			               to: 2
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 5.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'ello'.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_1_to_5_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 1
			               to: 5
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamplesTest >> testSmall_from_3_to_5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 3 to: 5.

	self assert: aNewRope size equals: 2.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'lo'.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamplesTest >> testSmall_from_3_to_5_do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 3
			               to: 5
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - testing' }
BlAttributeRopeExamplesTest >> testSmall_isEmpty [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlAttributeRopeExamplesTest >> testSmall_isLeaf [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isLeaf not.

	^ aRope
]

{ #category : #'examples - testing' }
BlAttributeRopeExamplesTest >> testSmall_isNotEmpty [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamplesTest >> testSmall_size [

	<sampleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope size equals: 5.

	^ aRope
]
