examples - composite selection
compositeSelect_from_1_to_3_and_4_to_6
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 3.
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