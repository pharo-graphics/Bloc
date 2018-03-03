geometry - empty
positionAtIndexInEmpty
	<gtExample>
	| aParagraph aPoint |
	
	aParagraph := self measuredEmpty.
	aPoint := aParagraph positionAt: 0.
	
	self assert: aPoint equals: 0 @ aParagraph baseline y.
	
	^ aPoint