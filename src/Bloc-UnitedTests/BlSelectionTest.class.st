"
I have been automatically converted and probably manually tweaked from BlSelectionExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlSelectionTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Selection'
}

{ #category : #'test seed' }
BlSelectionTest >> compositeSelection [

	^ BlCompositeSelection new
]

{ #category : #'test seed' }
BlSelectionTest >> monotoneSelection [

	^ BlMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom0To1 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 0 to: 1.

	self assert: aCompositeSelection from equals: 0.
	self assert: aCompositeSelection to equals: 1.
	self assert: aCompositeSelection displayString equals: '[0,1]'.
	self assert: aCompositeSelection printString equals: '[0,1]'.
	self assert: aCompositeSelection isNotEmpty.
	self deny: aCompositeSelection isEmpty.

	self
		assert: aCompositeSelection allSelections
		equals: { (BlMonotoneSelection from: 0 to: 1) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To1 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 1.

	self assert: aCompositeSelection isEmpty.
	self assert: aCompositeSelection displayString equals: ''.
	self assert: aCompositeSelection printString equals: ''.

	self assert: aCompositeSelection allSelections equals: {  }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To3 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 3.
	self assert: aCompositeSelection displayString equals: '[1,3]'.
	self assert: aCompositeSelection printString equals: '[1,3]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.

	self
		assert: aCompositeSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 3) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To3And2To6 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 2 to: 6.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,6]'.
	self assert: aCompositeSelection printString equals: '[1,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.

	self
		assert: aCompositeSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 6) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To3And4To6 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 4 to: 6.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][4,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][4,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.

	self assert: aCompositeSelection allSelections equals: { 
			(BlMonotoneSelection from: 1 to: 3).
			(BlMonotoneSelection from: 4 to: 6) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To3And5To6 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 5 to: 6.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self deny: aCompositeSelection isEmpty.

	self assert: aCompositeSelection allSelections equals: { 
			(BlMonotoneSelection from: 1 to: 3).
			(BlMonotoneSelection from: 5 to: 6) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom1To4And4To6 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 4.
	aCompositeSelection select: 4 to: 6.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,6]'.
	self assert: aCompositeSelection printString equals: '[1,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.

	self
		assert: aCompositeSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 6) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelectFrom5To6And1To3 [

	| aCompositeSelection |
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 5 to: 6.
	aCompositeSelection select: 1 to: 3.

	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.

	self assert: aCompositeSelection allSelections equals: { 
			(BlMonotoneSelection from: 1 to: 3).
			(BlMonotoneSelection from: 5 to: 6) }.

	^ aCompositeSelection
]

{ #category : #tests }
BlSelectionTest >> testCompositeSelection [

	^ BlCompositeSelection new
]

{ #category : #tests }
BlSelectionTest >> testMonotoneContainsIn1To1 [

	| aMonotoneSelection |
	aMonotoneSelection := self testMonotoneSelectFrom1To1.

	self assert: (aMonotoneSelection contains: 0) not.
	self assert: (aMonotoneSelection contains: 1).
	self assert: (aMonotoneSelection contains: 2) not.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneContainsIndexIn1To1 [

	| aMonotoneSelection |
	aMonotoneSelection := self testMonotoneSelectFrom1To1.

	self assert: (aMonotoneSelection containsIndex: 0) not.
	self assert: (aMonotoneSelection containsIndex: 1) not.
	self assert: (aMonotoneSelection containsIndex: 2) not.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneNeighbours1To1And3To4 [

	| from1to1 from3to4 |
	from1to1 := self testMonotoneSelectFrom1To1.
	from3to4 := self testMonotoneSelectFrom3To4.

	self assert: (from3to4 neighbours: from1to1) not.
	self assert: (from1to1 neighbours: from3to4) not.

	^ from3to4 neighbours: from1to1
]

{ #category : #tests }
BlSelectionTest >> testMonotoneNeighbours1To3And1To1 [

	| from1to3 from1to1 |
	from1to3 := self testMonotoneSelectFrom1To3.
	from1to1 := self testMonotoneSelectFrom1To1.

	self assert: (from1to3 neighbours: from1to1).
	self assert: (from1to1 neighbours: from1to3).

	^ from1to3 neighbours: from1to1
]

{ #category : #tests }
BlSelectionTest >> testMonotoneNeighbours1To3And3To4 [

	| from1to3 from3to4 |
	from1to3 := self testMonotoneSelectFrom1To3.
	from3to4 := self testMonotoneSelectFrom3To4.

	self assert: (from1to3 neighbours: from3to4).
	self assert: (from3to4 neighbours: from1to3).

	^ from1to3 neighbours: from3to4
]

{ #category : #tests }
BlSelectionTest >> testMonotoneNeighbours1To3And4To6 [

	| from1to3 from4to6 |
	from1to3 := self testMonotoneSelectFrom1To3.
	from4to6 := self testMonotoneSelectFrom4To6.

	self assert: (from1to3 neighbours: from4to6) not.
	self assert: (from4to6 neighbours: from1to3) not.

	^ from1to3 neighbours: from4to6
]

{ #category : #tests }
BlSelectionTest >> testMonotoneNeighbours1To4And4To6 [

	| from1to4 from4to6 |
	from1to4 := self testMonotoneSelectFrom1To4.
	from4to6 := self testMonotoneSelectFrom4To6.

	self assert: (from1to4 neighbours: from4to6).
	self assert: (from4to6 neighbours: from1to4).

	^ from1to4 neighbours: from4to6
]

{ #category : #tests }
BlSelectionTest >> testMonotoneRangeIncludesIn1To1 [

	| aMonotoneSelection |
	aMonotoneSelection := self testMonotoneSelectFrom1To1.

	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2) not.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneRangeIncludesIn1To3 [

	| aMonotoneSelection |
	aMonotoneSelection := self testMonotoneSelectFrom1To3.

	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2).
	self assert: (aMonotoneSelection rangeIncludes: 3).
	self assert: (aMonotoneSelection rangeIncludes: 4) not.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneRangeIncludesIn4To6 [

	| aMonotoneSelection |
	aMonotoneSelection := self testMonotoneSelectFrom4To6.

	self deny: (aMonotoneSelection rangeIncludes: 0).
	self deny: (aMonotoneSelection rangeIncludes: 1).
	self deny: (aMonotoneSelection rangeIncludes: 2).
	self deny: (aMonotoneSelection rangeIncludes: 3).
	self assert: (aMonotoneSelection rangeIncludes: 4).
	self assert: (aMonotoneSelection rangeIncludes: 5).
	self assert: (aMonotoneSelection rangeIncludes: 6).
	self deny: (aMonotoneSelection rangeIncludes: 7).

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneSelectFrom1To1 [

	| aMonotoneSelection |
	aMonotoneSelection := self monotoneSelection from: 1 to: 1.

	self assert: aMonotoneSelection displayString equals: '[1,1]'.
	self assert: aMonotoneSelection printString equals: '[1,1]'.
	self assert: aMonotoneSelection isEmpty.

	self
		assert: aMonotoneSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 1) }.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneSelectFrom1To3 [

	| aMonotoneSelection |
	aMonotoneSelection := self monotoneSelection from: 1 to: 3.

	self assert: aMonotoneSelection from equals: 1.
	self assert: aMonotoneSelection to equals: 3.
	self assert: aMonotoneSelection displayString equals: '[1,3]'.
	self assert: aMonotoneSelection printString equals: '[1,3]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.

	self
		assert: aMonotoneSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 3) }.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneSelectFrom1To4 [

	| aMonotoneSelection |
	aMonotoneSelection := self monotoneSelection from: 1 to: 4.

	self assert: aMonotoneSelection from equals: 1.
	self assert: aMonotoneSelection to equals: 4.
	self assert: aMonotoneSelection displayString equals: '[1,4]'.
	self assert: aMonotoneSelection printString equals: '[1,4]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.

	self
		assert: aMonotoneSelection allSelections
		equals: { (BlMonotoneSelection from: 1 to: 4) }.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneSelectFrom3To4 [

	| aMonotoneSelection |
	aMonotoneSelection := self monotoneSelection from: 3 to: 4.

	self assert: aMonotoneSelection from equals: 3.
	self assert: aMonotoneSelection to equals: 4.
	self assert: aMonotoneSelection displayString equals: '[3,4]'.
	self assert: aMonotoneSelection printString equals: '[3,4]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.

	self
		assert: aMonotoneSelection allSelections
		equals: { (BlMonotoneSelection from: 3 to: 4) }.

	^ aMonotoneSelection
]

{ #category : #tests }
BlSelectionTest >> testMonotoneSelectFrom4To6 [

	| aMonotoneSelection |
	aMonotoneSelection := self monotoneSelection from: 4 to: 6.

	self assert: aMonotoneSelection from equals: 4.
	self assert: aMonotoneSelection to equals: 6.
	self assert: aMonotoneSelection displayString equals: '[4,6]'.
	self assert: aMonotoneSelection printString equals: '[4,6]'.
	self assert: aMonotoneSelection isNotEmpty.
	self deny: aMonotoneSelection isEmpty.

	self
		assert: aMonotoneSelection allSelections
		equals: { (BlMonotoneSelection from: 4 to: 6) }.

	^ aMonotoneSelection
]
