examples - monotone selection
monotoneRangeIncludes_in_1_to_1
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_1.
	
	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2) not.
	
	^ aMonotoneSelection