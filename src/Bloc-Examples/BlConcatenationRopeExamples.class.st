"
I contain examples of a concatenation rope

"
Class {
	#name : #BlConcatenationRopeExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_0_to_0 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left left rope collection equals: ''.
	self assert: anAttributedRope left left attributes equals: { 1 }.

	self assert: anAttributedRope left right == aRope left.
	
	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_0_to_1 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left left rope collection equals: 'H'.
	self assert: anAttributedRope left left attributes equals: { 1 }.

	self assert: anAttributedRope left right collection equals: 'ello'.
	
	self assert: anAttributedRope right collection equals: 'World'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_0_to_10 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 10.

	self assert: anAttributedRope rope == aRope.
	self assert: anAttributedRope attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_0_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope left rope == aRope left.
	self assert: anAttributedRope left attributes equals: { 1 }.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_2_to_2 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left left collection equals: 'He'.

	self assert: anAttributedRope left right left attributes equals: { 1 }.
	self assert: anAttributedRope left right left rope collection equals: ''.
	
	self assert: anAttributedRope left right right collection equals: 'llo'.
	
	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_2_to_3 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 3.

	self assert: anAttributedRope left left collection equals: 'He'.

	self assert: anAttributedRope left right left attributes equals: { 1 }.
	self assert: anAttributedRope left right left rope collection equals: 'l'.
	
	self assert: anAttributedRope left right right collection equals: 'lo'.
	
	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_4_to_5 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.

	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left left collection equals: 'Hell'.

	self assert: anAttributedRope left right rope collection equals: 'o'.
	self assert: anAttributedRope left right attributes equals: { 1 }.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_4_to_6 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.

	anAttributedRope := aRope attributes: { 1 } from: 4 to: 6.

	self assert: anAttributedRope left left collection equals: 'Hell'.

	self assert: anAttributedRope left right rope collection equals: 'o'.
	self assert: anAttributedRope left right attributes equals: { 1 }.

	self assert: anAttributedRope right left rope collection equals: 'W'.
	self assert: anAttributedRope right left attributes equals: { 1 }.
	
	self assert: anAttributedRope right right collection equals: 'orld'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_5_to_10 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 10.

	self assert: anAttributedRope left == aRope left.
	
	self assert: anAttributedRope right rope == aRope right.
	self assert: anAttributedRope right attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_5_to_6 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.

	anAttributedRope := aRope attributes: { 1 } from: 5 to: 6.
	
	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left rope collection equals: 'W'.
	self assert: anAttributedRope right left attributes equals: { 1 }.

	self assert: anAttributedRope right right collection equals: 'orld'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_6_to_6 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 6 to: 6.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left collection equals: 'W'.

	self assert: anAttributedRope right right left attributes equals: { 1 }.
	self assert: anAttributedRope right right left rope collection equals: ''.
	
	self assert: anAttributedRope right right right collection equals: 'orld'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_6_to_7 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	
	anAttributedRope := aRope attributes: { 1 } from: 6 to: 7.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left collection equals: 'W'.

	self assert: anAttributedRope right right left attributes equals: { 1 }.
	self assert: anAttributedRope right right left rope collection equals: 'o'.
	
	self assert: anAttributedRope right right right collection equals: 'rld'.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlConcatenationRopeExamples >> attributes_small_9_to_10 [
	<gtExample>
	| aRope anAttributedRope |
	
	aRope := self small.
	anAttributedRope := aRope attributes: { 1 } from: 9 to: 10.

	self assert: anAttributedRope left == aRope left.
	
	self assert: anAttributedRope right left collection equals: 'Worl'.
	
	self assert: anAttributedRope right right rope collection equals: 'd'.
	self assert: anAttributedRope right right attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'as yet unclassified' }
BlConcatenationRopeExamples >> readStreamSmall [
	<gtExample>
	| rope stream |

	rope := self small.
	stream := rope readStream.

	self assert: stream next equals: $H.
	self assert: (stream next: 3) asString equals: 'ell'.
	self assert: stream upToEnd asString equals: 'oWorld'.
]

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> small [
	<gtExample>
	<label: 'Creates an instance of the rope of size smaller than combineLength'>
	| aRope |

	aRope := BlConcatenationRope
		left: (BlCollectionRope collection: 'Hello')
		right: (BlCollectionRope collection: 'World').

	self assert: aRope depth equals: 2.
	self assert: aRope size equals: 10.
	
	self assert: aRope left collection equals: 'Hello'.
	self assert: aRope right collection equals: 'World'.

	self assert: aRope isLeaf not.

	self assert: aRope size <= BlRope combineLength.
	
	^ aRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_0_to_1 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 0 to: 1.

	self assert: aNewRope collection equals: 'elloWorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_0_to_10 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 0 to: 10.

	self assert: aNewRope isEmpty.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_0_to_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 0 to: 5.

	self assert: aNewRope == aRope right.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_10_to_10 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 10 to: 10.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_1_to_2 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 1 to: 2.

	self assert: aNewRope collection equals: 'HlloWorld'.
	self assert: aNewRope size <= BlRope combineLength.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_4_to_4 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 4 to: 4.

	self assert: aNewRope collection equals: 'HelloWorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_4_to_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 4 to: 5.

	self assert: aNewRope collection equals: 'HellWorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_4_to_6 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 4 to: 6.

	self assert: aNewRope collection equals: 'Hellorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_5_to_10 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 5 to: 10.

	self assert: aNewRope == aRope left.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_5_to_5 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 5 to: 5.

	self assert: aNewRope collection equals: 'HelloWorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_5_to_6 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 5 to: 6.

	self assert: aNewRope collection equals: 'Helloorld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_6_to_7 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 6 to: 7.

	self assert: aNewRope collection equals: 'HelloWrld'.

	^ aNewRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> small_delete_9_to_10 [
	<gtExample>
	| aRope aNewRope |

	aRope := self small.
	aNewRope := aRope delete: 9 to: 10.

	self assert: aNewRope collection equals: 'HelloWorl'.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'HelloWorld'.

	^ theIterated
]

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> small_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self small.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_0_to_0_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 0 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_0_to_10 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 10.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_0_to_10_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 10 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'HelloWorld'.

	^ theIterated
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_0_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'H'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_0_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 0 to: 5.
	
	self assert: aNewRope == aRope left.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_0_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 0 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_10_to_10 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 10 to: 10.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_10_to_10_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 10 to: 10 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_1_to_1_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 1 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope collection equals: 'e'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_1_to_2_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 2 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'e'.

	^ theIterated
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_1_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 1 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'ello'.

	^ theIterated
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_3_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 3 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'lo'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_4_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 4 to: 5.
	
	self assert: aNewRope collection equals: 'o'.
	
	^ aNewRope
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_4_to_6 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 4 to: 6.
	
	self assert: aNewRope collection equals: 'oW'.
	
	^ aNewRope
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_5_to_10 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 5 to: 10.
	
	self assert: aNewRope == aRope right.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_5_to_10_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 5 to: 10 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'World'.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_5_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 5 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_5_to_5_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 5 to: 5 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #'examples - from to' }
BlConcatenationRopeExamples >> small_from_5_to_6 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self small.
	aNewRope := aRope from: 5 to: 6.
	
	self assert: aNewRope collection equals: 'W'.
	
	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_5_to_6_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 5 to: 6 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'W'.

	^ theIterated
]

{ #category : #'examples - enumeration' }
BlConcatenationRopeExamples >> small_from_9_to_10_do [
	<gtExample>
	| aRope theIterated |
	
	aRope := self small.
	theIterated := String streamContents: [ :aStream | aRope from: 9 to: 10 do: [ :eachCharacter| aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'd'.

	^ theIterated
]
