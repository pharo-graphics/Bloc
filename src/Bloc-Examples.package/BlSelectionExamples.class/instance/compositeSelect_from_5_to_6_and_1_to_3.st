examples - composite selection
compositeSelect_from_5_to_6_and_1_to_3
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