"
I have been automatically converted and probably manually tweaked from BlConcatenationRopeExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlConcatenationRopeTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests'
}

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall0To0 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 0.

	self assert: anAttributedRope left left rope collection equals: ''.
	self assert: anAttributedRope left left attributes equals: { 1 }.

	self assert: anAttributedRope left right == aRope left.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall0To1 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 0 to: 1.

	self assert: anAttributedRope left left rope collection equals: 'H'.
	self assert: anAttributedRope left left attributes equals: { 1 }.

	self assert: anAttributedRope left right collection equals: 'ello'.

	self assert: anAttributedRope right collection equals: 'World'.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall0To10 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 0 to: 10.

	self assert: anAttributedRope rope == aRope.
	self assert: anAttributedRope attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall0To5 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 0 to: 5.

	self assert: anAttributedRope left rope == aRope left.
	self assert: anAttributedRope left attributes equals: { 1 }.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall2To2 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 2 to: 2.

	self assert: anAttributedRope left left collection equals: 'He'.

	self
		assert: anAttributedRope left right left attributes
		equals: { 1 }.
	self
		assert: anAttributedRope left right left rope collection
		equals: ''.

	self
		assert: anAttributedRope left right right collection
		equals: 'llo'.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall2To3 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 2 to: 3.

	self assert: anAttributedRope left left collection equals: 'He'.

	self
		assert: anAttributedRope left right left attributes
		equals: { 1 }.
	self
		assert: anAttributedRope left right left rope collection
		equals: 'l'.

	self
		assert: anAttributedRope left right right collection
		equals: 'lo'.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall4To5 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 4 to: 5.

	self assert: anAttributedRope left left collection equals: 'Hell'.

	self assert: anAttributedRope left right rope collection equals: 'o'.
	self assert: anAttributedRope left right attributes equals: { 1 }.

	self assert: anAttributedRope right == aRope right.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall4To6 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 4 to: 6.

	self assert: anAttributedRope left left collection equals: 'Hell'.

	self assert: anAttributedRope left right rope collection equals: 'o'.
	self assert: anAttributedRope left right attributes equals: { 1 }.

	self assert: anAttributedRope right left rope collection equals: 'W'.
	self assert: anAttributedRope right left attributes equals: { 1 }.

	self assert: anAttributedRope right right collection equals: 'orld'.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall5To10 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 5 to: 10.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right rope == aRope right.
	self assert: anAttributedRope right attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall5To6 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 5 to: 6.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left rope collection equals: 'W'.
	self assert: anAttributedRope right left attributes equals: { 1 }.

	self assert: anAttributedRope right right collection equals: 'orld'.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall6To6 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 6 to: 6.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left collection equals: 'W'.

	self
		assert: anAttributedRope right right left attributes
		equals: { 1 }.
	self
		assert: anAttributedRope right right left rope collection
		equals: ''.

	self
		assert: anAttributedRope right right right collection
		equals: 'orld'.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall6To7 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.

	anAttributedRope := aRope attributes: { 1 } from: 6 to: 7.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left collection equals: 'W'.

	self
		assert: anAttributedRope right right left attributes
		equals: { 1 }.
	self
		assert: anAttributedRope right right left rope collection
		equals: 'o'.

	self
		assert: anAttributedRope right right right collection
		equals: 'rld'.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testAttributesSmall9To10 [

	<sampleInstance>
	| aRope anAttributedRope |
	aRope := self testSmall.
	anAttributedRope := aRope attributes: { 1 } from: 9 to: 10.

	self assert: anAttributedRope left == aRope left.

	self assert: anAttributedRope right left collection equals: 'Worl'.

	self assert: anAttributedRope right right rope collection equals: 'd'.
	self assert: anAttributedRope right right attributes equals: { 1 }.

	^ anAttributedRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testReadStreamSmall [

	<sampleInstance>
	| rope stream |
	rope := self testSmall.
	stream := rope readStream.

	self assert: stream next equals: $H.
	self assert: (stream next: 3) asString equals: 'ell'.
	self assert: stream upToEnd asString equals: 'oWorld'
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmall [

	<sampleInstance>
	<label:
	'Creates an instance of the rope of size smaller than combineLength'>
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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete0To0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 0.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete0To1 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 1.

	self assert: aNewRope collection equals: 'elloWorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete0To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 10.

	self assert: aNewRope isEmpty.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete0To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 0 to: 5.

	self assert: aNewRope == aRope right.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete10To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 10 to: 10.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete1To2 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 1 to: 2.

	self assert: aNewRope collection equals: 'HlloWorld'.
	self assert: aNewRope size <= BlRope combineLength.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete4To4 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 4.

	self assert: aNewRope collection equals: 'HelloWorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete4To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 5.

	self assert: aNewRope collection equals: 'HellWorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete4To6 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 4 to: 6.

	self assert: aNewRope collection equals: 'Hellorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete5To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 10.

	self assert: aNewRope == aRope left.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete5To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 5.

	self assert: aNewRope collection equals: 'HelloWorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete5To6 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 5 to: 6.

	self assert: aNewRope collection equals: 'Helloorld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete6To7 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 6 to: 7.

	self assert: aNewRope collection equals: 'HelloWrld'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDelete9To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope delete: 9 to: 10.

	self assert: aNewRope collection equals: 'HelloWorl'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallDo [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'HelloWorld'.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallEmpty [

	<sampleInstance>
	| aRope anEmpty |
	aRope := self testSmall.
	anEmpty := aRope empty.

	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: ''.

	^ anEmpty
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To0 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 0.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To0Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 10.

	self assert: aNewRope == aRope.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To10Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 0
			               to: 10
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'HelloWorld'.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To1Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 0 to: 5.

	self assert: aNewRope == aRope left.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom0To5Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom10To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 10 to: 10.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom10To10Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 10
			               to: 10
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom1To1Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom1To2 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 1 to: 2.

	self assert: aNewRope collection equals: 'e'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom1To2Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom1To5Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom3To5Do [

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

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom4To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 4 to: 5.

	self assert: aNewRope collection equals: 'o'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom4To6 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 4 to: 6.

	self assert: aNewRope collection equals: 'oW'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To10 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 5 to: 10.

	self assert: aNewRope == aRope right.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To10Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 5
			               to: 10
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'World'.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To5 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 5 to: 5.

	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: ''.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To5Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 5
			               to: 5
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: ''.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To6 [

	<sampleInstance>
	| aRope aNewRope |
	aRope := self testSmall.
	aNewRope := aRope from: 5 to: 6.

	self assert: aNewRope collection equals: 'W'.

	^ aNewRope
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom5To6Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 5
			               to: 6
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'W'.

	^ theIterated
]

{ #category : #tests }
BlConcatenationRopeTest >> testSmallFrom9To10Do [

	<sampleInstance>
	| aRope theIterated |
	aRope := self testSmall.
	theIterated := String streamContents: [ :aStream |
		               aRope
			               from: 9
			               to: 10
			               do: [ :eachCharacter |
			               aStream nextPut: eachCharacter ] ].

	self assert: theIterated equals: 'd'.

	^ theIterated
]
