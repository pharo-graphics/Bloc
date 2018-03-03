geometry - empty
indexAtFarBottomLeftPointInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex