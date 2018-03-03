geometry - empty
indexAtFarBottomPointInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex