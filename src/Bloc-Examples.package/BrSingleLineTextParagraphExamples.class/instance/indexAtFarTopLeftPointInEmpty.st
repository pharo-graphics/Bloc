geometry - empty
indexAtFarTopLeftPointInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) asPoint negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex