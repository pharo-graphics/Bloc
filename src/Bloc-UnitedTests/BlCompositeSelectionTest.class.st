"
A BlCompositeSelectionTest is a test class for testing the behavior of BlCompositeSelection
"
Class {
	#name : #BlCompositeSelectionTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Selection'
}

{ #category : #tests }
BlCompositeSelectionTest >> deselectedIndexesIn: aCompositeSelection among: selectedIndexes [

	^ selectedIndexes difference: aCompositeSelection indices
]

{ #category : #tests }
BlCompositeSelectionTest >> testDeselectAndDeselectedIndex [

	| s |
	s := BlCompositeSelection new.
	s selectIndexes: #(1 5 8 12 16).
	self assert: s indices equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
BlCompositeSelectionTest >> testDeselectAndDeselectedIndex2 [
	<expectedFailure>

	| s |
	s := BlCompositeSelection new.
	s deselectAll.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 8.
	s selectIndex: 12.
	s selectIndex: 16.
	self assert: s indices equals: #(1 5 8 12 16).
	s selectIndex: 1.
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
BlCompositeSelectionTest >> testDeselectAndDeselectedIndex3 [
	<expectedFailure>

	| s |
	s := BlCompositeSelection new.
	s select: 0 to: 8.
	self assert: s indices equals: #( 1 2 3 4 5 6 7 8 ).
	s deselectIndexes: #( 2 4 6 ).
	self assert: s indices equals: #( 1 3 5 7 8 ).
	s deselectIndexes: #( 2 4 6 ).
	self assert: s indices equals: #( 1 3 5 7 8 )
]

{ #category : #tests }
BlCompositeSelectionTest >> testEquals [

	| s |
	s := BlCompositeSelection new.
	self assert: s equals: BlCompositeSelection new

]

{ #category : #tests }
BlCompositeSelectionTest >> testEquals1 [

	| s s2 |
	s := BlCompositeSelection new.
	s select: 9 to: 20.
	s2 := BlCompositeSelection new.
	s2 select: 9 to: 20.
	self assert: s equals: s2

]

{ #category : #tests }
BlCompositeSelectionTest >> testEquals2 [
	<expectedFailure>

	| sc s |
	s := BlCompositeSelection new.
	1 to: 10 by: 2 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals size equals: 5.
	sc := s copy.
	1 to: 10 by: 1 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals size equals: 1.
	2 to: 99 by: 2 do: [ :idx | s deselectIndex: idx ].
	self assert: s intervals size equals: 5.
	self assert: s equals: sc
]

{ #category : #tests }
BlCompositeSelectionTest >> testSelectAllThenDeselectOneByOne [
	<expectedFailure>

	| s all |
	s := BlCompositeSelection new.
	all := (1 to: 48) asArray.
	s selectIndexes: all.
	s deselectIndex: 26.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(26).
	s deselectIndex: 28.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(26 28).
	s deselectIndex: 35.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(26 28 35).
	s deselectIndex: 18.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(18 26 28 35).
	s deselectIndex: 40.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(18 26 28 35 40).
	s deselectIndex: 31.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(18 26 28 31 35 40).
	s deselectIndex: 19.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(18 19 26 28 31 35 40).
	s deselectIndex: 17.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(17 18 19 26 28 31 35 40).
	s deselectIndex: 45.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(17 18 19 26 28 31 35 40 45).
	s deselectIndex: 48.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(17 18 19 26 28 31 35 40 45 48).
	s deselectIndex: 36.
	self assert: (self deselectedIndexesIn: s among: all) equals: #(17 18 19 26 28 31 35 36 40 45 48)
]
