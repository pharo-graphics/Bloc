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
BlCompositeSelectionTest >> testDeselectADeselectedIndex [

	| s |
	s := BlCompositeSelection new.
	s selectIndexes: #(1 5 8 12 16).
	self assert: s indices equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
BlCompositeSelectionTest >> testDeselectADeselectedIndex2 [
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
