geometry - empty
indexAtFarZeroInEmpty
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@0.
	
	self assert: anIndex equals: 0.
	
	^ anIndex