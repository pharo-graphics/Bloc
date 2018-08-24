"
I contain examples of a concatenation rope
"
Class {
	#name : #BlConcatenationRopeExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> concatenation [
	<gtExample>

	^ self leftRope append: self rightRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> delete_everything [
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: 1 to: anOriginalRope size.

	self assert: (anUpdatedRope isKindOf: BlCollectionRope).
	self assert: anUpdatedRope isEmpty.

	^ anUpdatedRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> delete_left_part [
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: 1 to: anOriginalRope left size.

	self assert: anUpdatedRope == anOriginalRope right.

	^ anUpdatedRope
]

{ #category : #'examples - delete' }
BlConcatenationRopeExamples >> delete_right_part [
	<gtExample>
	| anOriginalRope anUpdatedRope |

	anOriginalRope := self concatenation.
	anUpdatedRope := anOriginalRope delete: anOriginalRope left size + 1 to: anOriginalRope size.

	self assert: anUpdatedRope == anOriginalRope left.

	^ anUpdatedRope
]

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> leftRope [
	<gtExample>
	
	^ BlCollectionRope collection: '[I am a left part]'
]

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> rightRope [
	<gtExample>
	
	^ BlCollectionRope collection: '[I am a right part]'
]

{ #category : #'instance creation' }
BlConcatenationRopeExamples >> sizeOfConcatenation [
	<gtExample>
	| aConcatenationRope |
	
	aConcatenationRope := self concatenation.
	
	self
		assert: aConcatenationRope size
		equals: (aConcatenationRope left size + aConcatenationRope right size).
		
	^ aConcatenationRope size
]
