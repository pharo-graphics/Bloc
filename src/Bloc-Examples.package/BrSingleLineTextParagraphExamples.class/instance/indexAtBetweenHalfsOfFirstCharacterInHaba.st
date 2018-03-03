geometry - haba
indexAtBetweenHalfsOfFirstCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 2.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex