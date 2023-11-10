Class {
	#name : #BlSubRopeExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_empty_0_to_0 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall_empty.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope isNotEmpty.
	self assert: anAttributedRope attributes equals: { 1 }.
	self assert: anAttributedRope rope == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_0_to_0 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope collection equals: ''.

	self assert: anAttributedRope right == aRope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_0_to_1 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left attributes equals: { 1 }.

	self assert: anAttributedRope left attributes equals: { 1 }.
	self assert: anAttributedRope left rope size equals: 1.
	self assert: anAttributedRope left rope offset equals: 5.
	self assert: anAttributedRope left rope rope == aRope rope.

	self assert: anAttributedRope right size equals: 4.
	self assert: anAttributedRope right offset equals: 6.
	self assert: anAttributedRope right rope == aRope rope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_0_to_5 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope rope == aRope.
	self assert: anAttributedRope attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_2_to_2 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.


	self assert: anAttributedRope left size equals: 2.
	self assert: anAttributedRope left offset equals: 5.
	self assert: anAttributedRope left rope == aRope rope.

	self assert: anAttributedRope right left size equals: 0.
	self assert: anAttributedRope right left attributes equals: { 1 }.
	self assert: anAttributedRope right left rope collection equals: ''.

	self assert: anAttributedRope right right offset equals: 7.
	self assert: anAttributedRope right right rope == aRope rope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_4_to_5 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left size equals: 4.
	self assert: anAttributedRope left offset equals: 5.
	self assert: anAttributedRope left rope == aRope rope.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope size equals: 1.
	self assert: anAttributedRope right rope offset equals: 9.
	self assert: anAttributedRope right rope rope == aRope rope.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testAttributes_small_5_to_5 [

	<simpleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 5.

	self assert: anAttributedRope left == aRope.

	self assert: anAttributedRope right attributes equals: { 1 }.
	self assert: anAttributedRope right rope collection equals: ''.

	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlSubRopeExamplesTest >> testClear_attributes_empty_0_to_0 [

	<simpleInstance>
	| anEmptyRope aRopeWithoutAttributes |
	anEmptyRope := self testSmall_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes
]

{ #category : #'as yet unclassified' }
BlSubRopeExamplesTest >> testReadStreamSmall [

	| rope stream |
	rope := self testSmall.
	stream := rope readStream.

	self assert: stream next equals: $H.
	self assert: (stream next: 3) asString equals: 'ell'.
	self assert: stream upToEnd asString equals: 'o'
]

{ #category : #'instance creation' }
BlSubRopeExamplesTest >> testSmall [
	"Creates an instance of the rope of size smaller than combineLength with one attribute applied on the whole rope"

	<simpleInstance>
	| aCollectionRope aRope |
	aCollectionRope := BlCollectionRope collection: 'EarthHelloWorld'.

	aRope := BlSubRope rope: aCollectionRope offset: 5 length: 5.

	"attribute rope does not increase depth because it is just a plain wrapper"
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope offset equals: 5.
	self assert: aRope rope == aCollectionRope.
	self assert: aRope isLeaf not.
	self assert: aRope size <= BlRope combineLength.

	^ aRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamplesTest >> testSmall_at_each [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_children [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope children equals: { aRope rope }.

	^ aRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_0_to_0 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_0_to_1 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 1.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'ello'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_0_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 5.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_1_to_1 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 1.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_1_to_3 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 3.

	self assert: aNewRope size equals: 3.
	self assert: aNewRope collection equals: 'Hlo'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_1_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 5.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope collection equals: 'H'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_4_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 5.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'Hell'.

	^ aNewRope
]

{ #category : #'examples - deletion' }
BlSubRopeExamplesTest >> testSmall_delete_5_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 5.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamplesTest >> testSmall_depth [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_do [

	<simpleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'Hello'.

	^ theIterated
]

{ #category : #'instance creation' }
BlSubRopeExamplesTest >> testSmall_empty [

	<simpleInstance>
	| aRope anEmpty |
	aRope := self testSmall.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: ''.

	^ anEmpty
]

{ #category : #'examples - from to' }
BlSubRopeExamplesTest >> testSmall_from_0_to_0 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 0.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_0_to_0_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_0_to_1 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 1.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope offset equals: 5.
	self assert: aNewRope rope == aRope rope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_0_to_1_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_0_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 5.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_0_to_5_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_1_to_1 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 1.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_1_to_1_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_1_to_2 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 2.

	self assert: aNewRope size equals: 1.
	self assert: aNewRope offset equals: 6.
	self assert: aNewRope rope == aRope rope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_1_to_2_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_1_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 5.

	self assert: aNewRope size equals: 4.
	self assert: aNewRope offset equals: 6.
	self assert: aNewRope rope == aRope rope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_1_to_5_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_from_3_to_5 [

	<simpleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 3 to: 5.

	self assert: aNewRope size equals: 2.
	self assert: aNewRope offset equals: 8.
	self assert: aNewRope rope == aRope rope.

	^ aNewRope
]

{ #category : #'examples - enumeration' }
BlSubRopeExamplesTest >> testSmall_from_3_to_5_do [

	<simpleInstance>
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
BlSubRopeExamplesTest >> testSmall_isEmpty [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isEmpty not.

	^ aRope
]

{ #category : #'examples - testing' }
BlSubRopeExamplesTest >> testSmall_isLeaf [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isLeaf not.

	^ aRope
]

{ #category : #'examples - testing' }
BlSubRopeExamplesTest >> testSmall_isNotEmpty [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope isNotEmpty.

	^ aRope
]

{ #category : #'examples - accessing' }
BlSubRopeExamplesTest >> testSmall_size [

	<simpleInstance>
	| aRope |
	aRope := self testSmall.

	self assert: aRope size equals: 5.

	^ aRope
]
