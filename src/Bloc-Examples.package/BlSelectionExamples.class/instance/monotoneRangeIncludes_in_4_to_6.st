examples - monotone selection
monotoneRangeIncludes_in_4_to_6
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