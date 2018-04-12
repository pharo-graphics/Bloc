examples - composite selection
compositeSelect_from_1_to_1
	<gtExample>
	| aCompositeSelection |
	
	aCompositeSelection := self compositeSelection.
	aCompositeSelection select: 1 to: 1.
	
	self assert: aCompositeSelection from equals: 1.
	self assert: aCompositeSelection to equals: 1.
	self assert: aCompositeSelection displayString equals: '[1,1]'.
	self assert: aCompositeSelection printString equals: '[1,1]'.
	self assert: aCompositeSelection gtDisplayString equals: '[1,1]'.
	self assert: aCompositeSelection isNotEmpty.
	self assert: aCompositeSelection isEmpty not.
	
	self assert: aCompositeSelection allSelections equals: { BlMonotoneSelection from: 1 to: 1 }.

	^ aCompositeSelection