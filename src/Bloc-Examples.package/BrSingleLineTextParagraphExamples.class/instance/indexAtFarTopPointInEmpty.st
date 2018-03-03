geometry - empty
indexAtFarTopPointInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@(self ascent * 10) negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex