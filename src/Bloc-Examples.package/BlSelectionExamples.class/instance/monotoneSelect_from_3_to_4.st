examples - monotone selection
monotoneSelect_from_3_to_4
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