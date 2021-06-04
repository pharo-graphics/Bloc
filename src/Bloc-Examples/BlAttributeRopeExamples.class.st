"
I contain examples of an attribute rope

"
Class {
	#name : #BlAttributeRopeExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_empty_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small_empty.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope isNotEmpty.
	self assert: anAttributedRope attributes equals: { 0 . 1 }.
	self assert: anAttributedRope rope == aRope rope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left attributes equals: { 0 . 1 }.
	self assert: anAttributedRope left rope collection equals: ''.

	self assert: anAttributedRope right == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_0_to_1 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left attributes equals: { 0 . 1 }.
	self assert: anAttributedRope left rope collection equals: 'H'.

	self assert: anAttributedRope right attributes equals: { 0 }.
	self assert: anAttributedRope right rope collection equals: 'ello'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_0_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope rope == aRope rope.
	self assert: anAttributedRope attributes equals: { 0 . 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_2_to_2 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left rope collection equals: 'He'.
	self assert: anAttributedRope left attributes equals: { 0 }.

	self assert: anAttributedRope right left rope collection equals: ''.
	self assert: anAttributedRope right left attributes equals: { 0 . 1 }.

	self assert: anAttributedRope right right rope collection equals: 'llo'.
	self assert: anAttributedRope right right attributes equals: { 0 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_4_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left attributes equals: { 0 }.
	self assert: anAttributedRope left rope collection equals: 'Hell'.

	self assert: anAttributedRope right attributes equals: { 0 . 1 }.
	self assert: anAttributedRope right rope collection equals: 'o'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> attributes_small_5_to_5 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 5.

	self assert: anAttributedRope left == aRope.

	self assert: anAttributedRope right attributes equals: { 0 . 1 }.
	self assert: anAttributedRope right rope collection equals: ''.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> clear_attributes_empty_0_to_0 [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self small_empty.
	
	"clearing attributes on the empty attributed rope actually completely removes attributes"
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.
	
	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes collection equals: ''.
	self assert: aRopeWithoutAttributes == anEmptyRope rope.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> clear_attributes_small_0_to_0 [
	<gtExample>
	| aRope aRopeWithoutAttributes |
	
	aRope := self small.
	aRopeWithoutAttributes := aRope clearAttributes: 0 to: 0.
	
	self assert: aRopeWithoutAttributes == aRope.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - attributes' }
BlAttributeRopeExamples >> clear_attributes_small_0_to_1 [
	<gtExample>
	| aRope aRopeWithoutAttributes |
	
	aRope := self small.
	aRopeWithoutAttributes := aRope clearAttributes: 0 to: 1.
	
	self assert: aRopeWithoutAttributes left collection equals: 'H'.

	self assert: aRopeWithoutAttributes right attributes equals: { 0 }.
	self assert: aRopeWithoutAttributes right rope collection equals: 'ello'.

	^ aRopeWithoutAttributes
]

{ #category : #'examples - utility' }
BlAttributeRopeExamples >> mergeAttributes [
	<gtExample>
	| firstDuplicate secondDuplicate theOriginalAttributes theAddedAttributes theAttributesWithoutDuplicates |

	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.
	
	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.
	
	theOriginalAttributes := { firstDuplicate . 1 . 2  }.
	theAddedAttributes := { 3 . secondDuplicate }.
	
	theAttributesWithoutDuplicates := BlAttributeRope mergeAttributes: theOriginalAttributes and: theAddedAttributes.
	
	self assert: theAttributesWithoutDuplicates equals: { secondDuplicate . 1 . 2 . 3 }.
	
	^ theAttributesWithoutDuplicates
]

{ #category : #'examples - utility' }
BlAttributeRopeExamples >> removeDuplicates [
	<gtExample>
	| firstDuplicate secondDuplicate theOriginalAttributes theAttributesWithoutDuplicates |

	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.
	
	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.
	
	theOriginalAttributes := { firstDuplicate . 1 . 2 . 3 . secondDuplicate }.
	theAttributesWithoutDuplicates := BlAttributeRope removeDuplicates: theOriginalAttributes.
	
	self assert: theAttributesWithoutDuplicates equals: { secondDuplicate . 1 . 2 . 3 .  }.
	
	^ theAttributesWithoutDuplicates
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> small [
	<gtExample>
	<label: 'Creates an instance of the rope of size smaller than combineLength with one attribute applied on the whole rope'>
	| aRope |

	aRope := BlAttributeRope
		attributes: { 0 }
		rope: (BlCollectionRope collection: 'Hello').

	"attribute rope does not increase depth because it is just a plain wrapper"
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope attributes equals:  { 0 }.
	self assert: aRope rope collection equals: 'Hello'.
	self assert: aRope isLeaf not.
	self assert: aRope size <= BlRope combineLength.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamples >> small_at_each [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: (aRope at: 1) equals: $H.
	self assert: (aRope at: 2) equals: $e.
	self assert: (aRope at: 3) equals: $l.
	self assert: (aRope at: 4) equals: $l.
	self assert: (aRope at: 5) equals: $o.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamples >> small_children [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope children equals: { aRope rope }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_0_to_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 0 to: 5.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_1_to_3 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 3.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_4_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 4 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlAttributeRopeExamples >> small_delete_5_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 5 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamples >> small_depth [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> small_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self small.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	"is not actually empty, because it preserves the attributes of the original rope"
	self assert: anEmpty isNotEmpty.
	self assert: anEmpty attributes equals: { 0 }.
	self assert: anEmpty rope collection equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_0_to_0_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 0 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_0_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_0_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_1_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'e'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_1_to_2_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 2 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_1_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlAttributeRopeExamples >> small_from_3_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope attributes equals: { 0 }.
	self assert: aNewRope rope collection equals: 'lo'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlAttributeRopeExamples >> small_from_3_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 3 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - testing' }
BlAttributeRopeExamples >> small_isEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlAttributeRopeExamples >> small_isLeaf [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isLeaf not.

	^ aRope
]

{ #category : #'examples - testing' }
BlAttributeRopeExamples >> small_isNotEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlAttributeRopeExamples >> small_size [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope size equals: 5.

	^ aRope
]
