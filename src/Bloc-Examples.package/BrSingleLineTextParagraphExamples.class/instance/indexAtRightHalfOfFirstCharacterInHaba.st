geometry - haba
indexAtRightHalfOfFirstCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 1.5) @ self ascent.
	
	self assert: anIndex equals: 1.
	
	^ anIndex