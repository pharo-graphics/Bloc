geometry - empty
indexAtFarBottomRightPointInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex