"
I exemplify selection interval

"
Class {
	#name : #BlSelectionExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Selection'
}

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_0_to_1 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 0 to: 1.
	
	self assert: aCompositeSelection from equals: 0.
	self assert: aCompositeSelection to equals: 1.
	self assert: aCompositeSelection displayString equals: '[0,1]'.
	self assert: aCompositeSelection printString equals: '[0,1]'.
	self assert: aCompositeSelection gtDisplayString equals: '[0,1]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self assert: aCompositeSelection allSelections equals: { BlMonotoneSelection from: 0 to: 1 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_1 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 1.
	
	self assert: aCompositeSelection isEmpty.
	self assert: aCompositeSelection displayString equals: ''.
	self assert: aCompositeSelection printString equals: ''.
	self assert: aCompositeSelection gtDisplayString equals: ''.
	
	self assert: aCompositeSelection allSelections equals: {}.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_3 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 3.
	self assert: aCompositeSelection displayString equals: '[1,3]'.
	self assert: aCompositeSelection printString equals: '[1,3]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,3]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self assert: aCompositeSelection allSelections equals: { BlMonotoneSelection from: 1 to: 3 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_3_and_2_to_6 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 2 to: 6.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,6]'.
	self assert: aCompositeSelection printString equals: '[1,6]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self assert: aCompositeSelection allSelections equals: { BlMonotoneSelection from: 1 to: 6 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_3_and_4_to_6 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 4 to: 6.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][4,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][4,6]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,3][4,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self
		assert: aCompositeSelection allSelections
		equals: {
			BlMonotoneSelection from: 1 to: 3.
			BlMonotoneSelection from: 4 to: 6 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_3_and_5_to_6 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
	aCompositeSelection select: 5 to: 6.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self
		assert: aCompositeSelection allSelections
		equals: { BlMonotoneSelection from: 1 to: 3 . BlMonotoneSelection from: 5 to: 6 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_1_to_4_and_4_to_6 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 4.
	aCompositeSelection select: 4 to: 6.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,6]'.
	self assert: aCompositeSelection printString equals: '[1,6]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self assert: aCompositeSelection allSelections equals: { BlMonotoneSelection from: 1 to: 6 }.

	^ aCompositeSelection
]

{ #category : #'examples - composite selection' }
BlSelectionExamples >> compositeSelect_from_5_to_6_and_1_to_3 [
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 5 to: 6.
	aCompositeSelection select: 1 to: 3.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 6.
	self assert: aCompositeSelection displayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection printString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,3][5,6]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self
		assert: aCompositeSelection allSelections
		equals: { BlMonotoneSelection from: 1 to: 3 . BlMonotoneSelection from: 5 to: 6 }.

	^ aCompositeSelection
]

{ #category : #'examples - instance creation' }
BlSelectionExamples >> compositeSelection [
	<gtExample>
	
	^ BlCompositeSelection new
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneContainsIndex_in_1_to_1 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_1.
	
	self assert: (aMonotoneSelection containsIndex: 0) not.
	self assert: (aMonotoneSelection containsIndex: 1) not.
	self assert: (aMonotoneSelection containsIndex: 2) not.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneContains_in_1_to_1 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_1.
	
	self assert: (aMonotoneSelection contains: 0) not.
	self assert: (aMonotoneSelection contains: 1).
	self assert: (aMonotoneSelection contains: 2) not.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneNeighbours_1_to_1_and_3_to_4 [
	<gtExample>
	| from1to1 from3to4  |
	
	from1to1 := self monotoneSelect_from_1_to_1.
	from3to4 := self monotoneSelect_from_3_to_4.
	
	self assert: (from3to4 neighbours: from1to1) not.
	self assert: (from1to1 neighbours: from3to4) not.
	
	^ (from3to4 neighbours: from1to1)
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneNeighbours_1_to_3_and_1_to_1 [
	<gtExample>
	| from1to3 from1to1 |
	
	from1to3 := self monotoneSelect_from_1_to_3.
	from1to1 := self monotoneSelect_from_1_to_1.
	
	self assert: (from1to3 neighbours: from1to1).
	self assert: (from1to1 neighbours: from1to3).
	
	^ (from1to3 neighbours: from1to1)
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneNeighbours_1_to_3_and_3_to_4 [
	<gtExample>
	| from1to3 from3to4 |
	
	from1to3 := self monotoneSelect_from_1_to_3.
	from3to4 := self monotoneSelect_from_3_to_4.
	
	self assert: (from1to3 neighbours: from3to4).
	self assert: (from3to4 neighbours: from1to3).
	
	^ (from1to3 neighbours: from3to4)
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneNeighbours_1_to_3_and_4_to_6 [
	<gtExample>
	| from1to3 from4to6 |

	from1to3 := self monotoneSelect_from_1_to_3.
	from4to6 := self monotoneSelect_from_4_to_6.

	self assert: (from1to3 neighbours: from4to6) not.
	self assert: (from4to6 neighbours: from1to3) not.

	^ (from1to3 neighbours: from4to6)
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneNeighbours_1_to_4_and_4_to_6 [
	<gtExample>
	| from1to4 from4to6 |
	
	from1to4 := self monotoneSelect_from_1_to_4.
	from4to6 := self monotoneSelect_from_4_to_6.

	self assert: (from1to4 neighbours: from4to6).
	self assert: (from4to6 neighbours: from1to4).

	^ (from1to4 neighbours: from4to6)
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneRangeIncludes_in_1_to_1 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_1.
	
	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2) not.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneRangeIncludes_in_1_to_3 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_3.
	
	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2).
	self assert: (aMonotoneSelection rangeIncludes: 3).
	self assert: (aMonotoneSelection rangeIncludes: 4) not.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneRangeIncludes_in_4_to_6 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_4_to_6.
	
	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1) not.
	self assert: (aMonotoneSelection rangeIncludes: 2) not.
	self assert: (aMonotoneSelection rangeIncludes: 3) not.
	self assert: (aMonotoneSelection rangeIncludes: 4).
	self assert: (aMonotoneSelection rangeIncludes: 5).
	self assert: (aMonotoneSelection rangeIncludes: 6).
	self assert: (aMonotoneSelection rangeIncludes: 7) not.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneSelect_from_1_to_1 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelection from: 1 to: 1.
	
	self assert: aMonotoneSelection displayString equals: '[1,1]'.
	self assert: aMonotoneSelection printString equals: '[1,1]'.
	self assert: aMonotoneSelection gtDisplayString equals: '[1,1]'.
	self assert: aMonotoneSelection isEmpty.
	
	self assert: aMonotoneSelection allSelections equals: { BlMonotoneSelection from: 1 to: 1 }.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneSelect_from_1_to_3 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelection from: 1 to: 3.
	
	self assert: aMonotoneSelection from equals: 1.
	self assert: aMonotoneSelection to equals: 3.
	self assert: aMonotoneSelection displayString equals: '[1,3]'.
	self assert: aMonotoneSelection printString equals: '[1,3]'.
	self assert: aMonotoneSelection gtDisplayString equals: '[1,3]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.
	
	self assert: aMonotoneSelection allSelections equals: { BlMonotoneSelection from: 1 to: 3 }.
	
	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneSelect_from_1_to_4 [
	<gtExample>
	| aMonotoneSelection |

	aMonotoneSelection := self monotoneSelection from: 1 to: 4.

	self assert: aMonotoneSelection from equals: 1.
	self assert: aMonotoneSelection to equals: 4.
	self assert: aMonotoneSelection displayString equals: '[1,4]'.
	self assert: aMonotoneSelection printString equals: '[1,4]'.
	self assert: aMonotoneSelection gtDisplayString equals: '[1,4]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.

	self assert: aMonotoneSelection allSelections equals: { BlMonotoneSelection from: 1 to: 4 }.

	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneSelect_from_3_to_4 [
	<gtExample>
	| aMonotoneSelection |

	aMonotoneSelection := self monotoneSelection from: 3 to: 4.

	self assert: aMonotoneSelection from equals: 3.
	self assert: aMonotoneSelection to equals: 4.
	self assert: aMonotoneSelection displayString equals: '[3,4]'.
	self assert: aMonotoneSelection printString equals: '[3,4]'.
	self assert: aMonotoneSelection gtDisplayString equals: '[3,4]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.

	self assert: aMonotoneSelection allSelections equals: { BlMonotoneSelection from: 3 to: 4 }.

	^ aMonotoneSelection
]

{ #category : #'examples - monotone selection' }
BlSelectionExamples >> monotoneSelect_from_4_to_6 [
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelection from: 4 to: 6.
	
	self assert: aMonotoneSelection from equals: 4.
	self assert: aMonotoneSelection to equals: 6.
	self assert: aMonotoneSelection displayString equals: '[4,6]'.
	self assert: aMonotoneSelection printString equals: '[4,6]'.
	self assert: aMonotoneSelection gtDisplayString equals: '[4,6]'.
	self assert: aMonotoneSelection isNotEmpty.
	self assert: aMonotoneSelection isEmpty not.
	
	self assert: aMonotoneSelection allSelections equals: { BlMonotoneSelection from: 4 to: 6 }.
	
	^ aMonotoneSelection
]

{ #category : #'examples - instance creation' }
BlSelectionExamples >> monotoneSelection [
	<gtExample>
	
	^ BlMonotoneSelection
]
