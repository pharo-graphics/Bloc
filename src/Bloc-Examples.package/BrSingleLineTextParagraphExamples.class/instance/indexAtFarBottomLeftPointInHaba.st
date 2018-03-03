geometry - haba
indexAtFarBottomLeftPointInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth * self haba size * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex