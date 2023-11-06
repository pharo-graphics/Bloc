"
I have been automatically converted and probably manually tweaked from BlChildrenSubsetExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : 'BlChildrenSubsetTest',
	#superclass : 'TestCase',
	#category : 'Bloc-UnitedTests-Children',
	#package : 'Bloc-UnitedTests',
	#tag : 'Children'
}

{ #category : 'tests' }
BlChildrenSubsetTest >> accountedByLayout [
	^ self testAccountedByLayout 
]

{ #category : 'tests' }
BlChildrenSubsetTest >> childrenArrayWith5Elements [

	^ self testChildrenArrayWith5Elements
	
]

{ #category : 'tests' }
BlChildrenSubsetTest >> elementWithChildren [
	^ self testElementWithChildren
	
]

{ #category : 'tests' }
BlChildrenSubsetTest >> ignoredByLayout [
	^ self testIgnoredByLayout 
]

{ #category : 'fixture' }
BlChildrenSubsetTest >> newChildAt: anIndex [
	| anElement |
	anElement := BlElement new.
	anElement userData at: #index put: anIndex.
	^ anElement
]

{ #category : 'metadata' }
BlChildrenSubsetTest >> originClassName [
	"This test was generated from..."
	^ 'BlChildrenSubsetExamples'
]

{ #category : 'tests' }
BlChildrenSubsetTest >> reversed [
	^ self testReversed
	
]

{ #category : 'tests' }
BlChildrenSubsetTest >> sortedByElevation [
	^ self testSortedByElevation
	
	
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testAccountedByLayout [
	
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray accountedByLayout.
	self assert: childrenIterator size equals: 3.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 1.
	self assert: (childrenIterator second userData at: #index) equals: 3.
	self assert: (childrenIterator third userData at: #index) equals: 5.
	self
		assert: childrenIterator asArray
		equals:
			{(childrenArray at: 1).
			(childrenArray at: 3).
			(childrenArray at: 5)}.
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testAccountedByLayoutAndIgnoredByLayout [
	
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorIgnoredByLayout := childrenIterator accountedByLayout.
	self assert: childrenIteratorIgnoredByLayout size equals: 0.
	self
		assert: childrenIteratorIgnoredByLayout superset
		equals: childrenIterator.
	^ childrenIteratorIgnoredByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testAccountedByLayoutAndReversed [
	
	| childrenIterator childrenIteratorReversed |
	childrenIterator := self accountedByLayout.
	childrenIteratorReversed := childrenIterator reversed.
	self assert: childrenIteratorReversed size equals: 3.
	self
		assert: childrenIteratorReversed superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorReversed first userData at: #index)
		equals: 5.
	self
		assert: (childrenIteratorReversed second userData at: #index)
		equals: 3.
	self
		assert: (childrenIteratorReversed third userData at: #index)
		equals: 1.
	^ childrenIteratorReversed
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testAccountedByLayoutChildrenFromElement [
	
	| element accountedByLayoutChildren |
	element := self elementWithChildren.
	accountedByLayoutChildren := element children accountedByLayout.
	self assert: accountedByLayoutChildren size equals: 3.
	^ accountedByLayoutChildren
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testAccountedByLayoutTwice [
	
	| childrenIterator childrenIteratorAccountedByLayout |
	childrenIterator := self accountedByLayout.
	childrenIteratorAccountedByLayout := childrenIterator
		accountedByLayout.
	self assert: childrenIteratorAccountedByLayout == childrenIterator.
	^ childrenIteratorAccountedByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testChildrenArrayWith5Elements [
	
	| childrenArray zIndex |
	childrenArray := BlChildrenArray new.
	1 to: 5 do:
		[ :index | childrenArray add: (self newChildAt: index) at: index ].
	(childrenArray at: 2) constraints ignoreByLayout.
	(childrenArray at: 4) constraints ignoreByLayout.
	zIndex := #(1 5 3 2 4).
	zIndex
		withIndexDo: [ :aZIndex :index | (childrenArray at: index) zIndex: aZIndex ].
	self assert: childrenArray size equals: 5.
	self assert: childrenArray isNotEmpty.
	self assert: (childrenArray at: 1) constraints ignoredByLayout not.
	self assert: (childrenArray at: 3) constraints ignoredByLayout not.
	self assert: (childrenArray at: 5) constraints ignoredByLayout not.
	^ childrenArray
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testChildrenWithMultipleCombinedSubsets [
	
	| element children |
	element := self elementWithChildren.
	children := element children accountedByLayout reversed
		sortedByElevation reversed.
	self assert: children size equals: 3.
	self assert: (children first userData at: #index) equals: 5.
	self assert: (children second userData at: #index) equals: 3.
	self assert: (children third userData at: #index) equals: 1.
	self
		assert: children superset superset superset superset
		equals: element children.
	^ children
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testElementWithChildren [
	
	| element |
	element := BlElement new.
	self childrenArrayWith5Elements
		do: [ :aChild | element addChild: aChild ].
	self assert: element children size equals: 5.
	^ element
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayout [
	
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray ignoredByLayout.
	self assert: childrenIterator size equals: 2.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 2.
	self assert: (childrenIterator second userData at: #index) equals: 4.
	self
		assert: childrenIterator asArray
		equals:
			{(childrenArray at: 2).
			(childrenArray at: 4)}.
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayoutAndAcountedByLayout [
	
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorAcountedByLayout := childrenIterator
		accountedByLayout.
	self assert: childrenIteratorAcountedByLayout size equals: 0.
	self
		assert: childrenIteratorAcountedByLayout superset
		equals: childrenIterator.
	^ childrenIteratorAcountedByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayoutAndReverse [
	
	| childrenIterator childrenIteratorReversed |
	childrenIterator := self ignoredByLayout.
	childrenIteratorReversed := childrenIterator reversed.
	self assert: childrenIteratorReversed size equals: 2.
	self
		assert: childrenIteratorReversed superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorReversed first userData at: #index)
		equals: 4.
	self
		assert: (childrenIteratorReversed second userData at: #index)
		equals: 2.
	^ childrenIteratorReversed
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayoutExplicitCreation [
	
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := BlChildrenIgnoredByLayout on: childrenArray.
	self assert: childrenIterator size equals: 2.
	self assert: childrenIterator superset equals: childrenArray.
	self assert: (childrenIterator first userData at: #index) equals: 2.
	self assert: (childrenIterator second userData at: #index) equals: 4.
	self
		assert: childrenIterator asArray
		equals:
			{(childrenArray at: 2).
			(childrenArray at: 4)}.
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayoutFromElement [
	
	| element ignoredByLayoutChildren |
	element := self elementWithChildren.
	ignoredByLayoutChildren := element children ignoredByLayout.
	self assert: ignoredByLayoutChildren size equals: 2.
	^ ignoredByLayoutChildren
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testIgnoredByLayoutTwice [
	
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self ignoredByLayout.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.
	self assert: childrenIteratorIgnoredByLayout identicalTo: childrenIterator.
	^ childrenIteratorIgnoredByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testReversed [
	
	| childrenArray childrenIterator |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray reversed.
	self assert: childrenIterator size equals: 5.
	self assert: childrenIterator superset equals: childrenArray.
	1 to: 5 do: [ :index | 
		self
			assert: ((childrenIterator at: index) userData at: #index)
			equals: 5 - index + 1 ].
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testReversedAndAcountedByLayout [
	
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self reversed.
	childrenIteratorAcountedByLayout := childrenIterator
		accountedByLayout.
	self assert: childrenIteratorAcountedByLayout size equals: 3.
	self
		assert: childrenIteratorAcountedByLayout superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorAcountedByLayout first userData at: #index)
		equals: 5.
	self
		assert: (childrenIteratorAcountedByLayout second userData at: #index)
		equals: 3.
	self
		assert: (childrenIteratorAcountedByLayout third userData at: #index)
		equals: 1.
	self
		assert: childrenIteratorAcountedByLayout asArray
		equals:
			{(childrenIterator at: 1).
			(childrenIterator at: 3).
			(childrenIterator at: 5)}.
	^ childrenIteratorAcountedByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testReversedAndIgnoredByLayout [
	
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self reversed.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.
	self assert: childrenIteratorIgnoredByLayout size equals: 2.
	self
		assert: childrenIteratorIgnoredByLayout superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorIgnoredByLayout first userData at: #index)
		equals: 4.
	self
		assert: (childrenIteratorIgnoredByLayout second userData at: #index)
		equals: 2.
	self
		assert: childrenIteratorIgnoredByLayout asArray
		equals:
			{(childrenIterator at: 2).
			(childrenIterator at: 4)}.
	^ childrenIteratorIgnoredByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testReversedChildrenFromElement [
	
	| element reversedChildren |
	element := self elementWithChildren.
	reversedChildren := element children reversed.
	self assert: reversedChildren size equals: 5.
	^ reversedChildren
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testReversedTwice [
	
	| childrenIterator |
	childrenIterator := self reversed reversed.
	self assert: childrenIterator size equals: 5.
	self assert: (childrenIterator isKindOf: BlChildrenArray).	"Could be improved"
	1 to: 5 do: [ :index | 
		self
			assert: ((childrenIterator at: index) userData at: #index)
			equals: index ].
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevation [
	
	| childrenArray childrenIterator expectedOrder |
	childrenArray := self childrenArrayWith5Elements.
	childrenIterator := childrenArray sortedByElevation.
	self assert: childrenIterator size equals: 5.
	self assert: childrenIterator superset equals: childrenArray.
	expectedOrder := #(1 4 3 5 2).
	1 to: 5 do: [ :index | 
		self
			assert: ((childrenIterator at: index) userData at: #index)
			equals: (expectedOrder at: index) ].
	^ childrenIterator
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevationAndAcountedByLayout [
	
	| childrenIterator childrenIteratorAcountedByLayout |
	childrenIterator := self sortedByElevation.
	childrenIteratorAcountedByLayout := childrenIterator
		accountedByLayout.
	self assert: childrenIteratorAcountedByLayout size equals: 3.
	self
		assert: childrenIteratorAcountedByLayout superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorAcountedByLayout first userData at: #index)
		equals: 1.
	self
		assert: (childrenIteratorAcountedByLayout second userData at: #index)
		equals: 3.
	self
		assert: (childrenIteratorAcountedByLayout third userData at: #index)
		equals: 5.
	^ childrenIteratorAcountedByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevationAndIgnoredByLayout [
	
	| childrenIterator childrenIteratorIgnoredByLayout |
	childrenIterator := self sortedByElevation.
	childrenIteratorIgnoredByLayout := childrenIterator ignoredByLayout.
	self assert: childrenIteratorIgnoredByLayout size equals: 2.
	self
		assert: childrenIteratorIgnoredByLayout superset
		equals: childrenIterator.
	self
		assert: (childrenIteratorIgnoredByLayout first userData at: #index)
		equals: 4.
	self
		assert: (childrenIteratorIgnoredByLayout second userData at: #index)
		equals: 2.
	^ childrenIteratorIgnoredByLayout
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevationAndReversed [
	
	| childrenIterator childrenIteratorReversed expectedOrder |
	childrenIterator := self sortedByElevation.
	childrenIteratorReversed := childrenIterator reversed.
	self assert: childrenIteratorReversed size equals: 5.
	self
		assert: childrenIteratorReversed superset
		equals: childrenIterator.
	expectedOrder := #(2 5 3 4 1).
	1 to: 5 do: [ :index | 
		self
			assert: ((childrenIteratorReversed at: index) userData at: #index)
			equals: (expectedOrder at: index) ].
	^ childrenIteratorReversed
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevationFromElement [
	
	| element sortedByElevationChildren |
	element := self elementWithChildren.
	sortedByElevationChildren := element children sortedByElevation.
	self assert: sortedByElevationChildren size equals: 5.
	^ sortedByElevationChildren
]

{ #category : 'tests' }
BlChildrenSubsetTest >> testSortedByElevationTwice [
	
	| childrenIterator childrenIteratorSortedByElevation |
	childrenIterator := self sortedByElevation.
	childrenIteratorSortedByElevation := childrenIterator
		sortedByElevation.
	self assert: childrenIteratorSortedByElevation identicalTo: childrenIterator.
	^ childrenIteratorSortedByElevation
]
