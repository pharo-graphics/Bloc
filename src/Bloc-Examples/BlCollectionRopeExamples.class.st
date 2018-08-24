"
I contain examples of a collection rope
"
Class {
	#name : #BlCollectionRopeExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> attributesOnEmptyRope [
	<gtExample>
	| anEmptyRope anAttributedRope |
	
	anEmptyRope := self small_empty.
	anAttributedRope := anEmptyRope attributes: { 1 }.

	self assert: anAttributedRope isEmpty.
	self assert: anAttributedRope rope == anEmptyRope.
	self assert: anAttributedRope attributes equals: { 1 }.
	
	^ anAttributedRope
]

{ #category : #'examples - attributes' }
BlCollectionRopeExamples >> clearAttributesOnEmptyRope [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self small_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes
]

{ #category : #'instance creation' }
BlCollectionRopeExamples >> smallCollection [
	<gtExample>
	| aRope |

	aRope := BlCollectionRope collection: 'Hello'.
	
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope collection equals: 'Hello'.
	self assert: aRope isLeaf.
	
	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_at_each [
	<gtExample>
	| aRope |
	
	aRope := self smallCollection.

	self assert: (aRope at: 1) equals: $H.
	self assert: (aRope at: 2) equals: $e.
	self assert: (aRope at: 3) equals: $l.
	self assert: (aRope at: 4) equals: $l.
	self assert: (aRope at: 5) equals: $o.
	
	^ aRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 0 to: 0.
	
	self assert: aNewRope size equals: 5.
	self assert: aNewRope collection equals: 'Hello'.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'ello' asArray.
	
	^ aNewRope
]

{ #category : #'examples - deletion' }
BlCollectionRopeExamples >> small_delete_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: #().
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_depth [
	<gtExample>
	| aRope |
	
	aRope := self smallCollection.

	self assert: aRope depth equals: 1.

	^ aRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_empty [
	<gtExample>
	| aRope anEmpty |

	aRope := self smallCollection.
	anEmpty := aRope empty.
	
	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: #().

	^ anEmpty
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_from_0_to_0 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: #().
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_from_1_to_1 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope collection equals: 'H'.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_from_1_to_2 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope collection equals: 'He'.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_from_1_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_from_3_to_5 [
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope collection equals: 'llo'.
	
	^ aNewRope
]

{ #category : #'examples - accessing' }
BlCollectionRopeExamples >> small_size [
	<gtExample>
	| aRope |
	
	aRope := self smallCollection.

	self assert: aRope size equals: 5.

	^ aRope
]
