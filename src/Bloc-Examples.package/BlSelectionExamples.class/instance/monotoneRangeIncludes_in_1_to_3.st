examples - monotone selection
monotoneRangeIncludes_in_1_to_3
	<gtExample>
	| aMonotoneSelection |
	
	aMonotoneSelection := self monotoneSelect_from_1_to_3.
	
	self assert: (aMonotoneSelection rangeIncludes: 0) not.
	self assert: (aMonotoneSelection rangeIncludes: 1).
	self assert: (aMonotoneSelection rangeIncludes: 2).
	self assert: (aMonotoneSelection rangeIncludes: 3).
	self assert: (aMonotoneSelection rangeIncludes: 4) not.
	
	^ aMonotoneSelection