examples - monotone selection
monotoneSelect_from_4_to_6
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