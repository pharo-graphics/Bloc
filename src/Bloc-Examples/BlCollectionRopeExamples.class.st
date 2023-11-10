"
I contain examples of a collection rope

"
Class {
	#name : #BlCollectionRopeExamples,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_empty_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small_empty.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope isNotEmpty.
	self assert: anAttributedRope attributes equals: { 1 }.
	self assert: anAttributedRope rope == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope asString equals: ''.

	self assert: anAttributedRope right == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_0_to_1 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope asString equals: 'H'.

	self assert: anAttributedRope right asString equals: 'ello'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_0_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope rope == aRope.
	self assert: anAttributedRope attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_2_to_2 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left asString equals: 'He'.

	self assert: anAttributedRope right left rope asString equals: ''.
	self assert: anAttributedRope right left attributes equals: { 1 }.

	self assert: anAttributedRope right right asString equals: 'llo'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_4_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left asString equals: 'Hell'.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope asString equals: 'o'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributes_small_5_to_5 [
	<gtExample>
	| aRope anAttributedRope |

	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 5.

	self assert: anAttributedRope left asString equals: 'Hello'.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope asString equals: ''.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> clear_attributes_empty_0_to_0 [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self small_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes
]

{ #category : #'instance creation' }
BlCollectionRopeExamples >> small [
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
BlCollectionRopeExamples >> small_at_each [
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
BlCollectionRopeExamples >> small_children [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope children equals: { }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 0.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 0 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_1_to_3 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 3.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope asString equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_4_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 4 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_5_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope delete: 5 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_depth [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlCollectionRopeExamples >> small_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self small.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty asString equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_0_to_0_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 0 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_0_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_0_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_0_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope asString equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_1_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope asString equals: 'e'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_1_to_2_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 2 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope asString equals: 'ello'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_1_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlCollectionRopeExamples >> small_from_3_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope asString equals: 'lo'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlCollectionRopeExamples >> small_from_3_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 3 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_0 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 0.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: '123Hello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_1 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 1.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'H123ello'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_2 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 2.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'He123llo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_3 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 3.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hel123lo'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_4 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 4.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hell123o'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_rope_123_at_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insert: (BlCollectionRope collection: '123') at: 5.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hello123'.

	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_0 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 0.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: '123Hello'.
	
	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_1 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 1.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'H123ello'.
	
	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_2 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 2.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'He123llo'.
	
	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_3 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 3.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hel123lo'.
	
	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_4 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 4.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hell123o'.
	
	^ aNewRope
]

{ #category : #'examples - insertion' }
BlCollectionRopeExamples >> small_insert_string_123_at_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope insertItems: '123' at: 5.

	self assert: aNewRope size equals: 8.
	self assert: aNewRope asString equals: 'Hello123'.

	^ aNewRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamples >> small_isEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamples >> small_isLeaf [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isLeaf.

	^ aRope
]

{ #category : #'examples - testing' }
BlCollectionRopeExamples >> small_isNotEmpty [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_size [
	<gtExample>
	| aRope |
	
	aRope := self small.

	self assert: aRope size equals: 5.

	^ aRope
]
