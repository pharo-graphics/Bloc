geometry - empty
spanAtIndexInEmpty
	<gtExample>
	| aParagraph aSpan |
	
	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtIndex: 0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan