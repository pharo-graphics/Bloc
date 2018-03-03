geometry - haba
indexAtLeftHalfOfFirstCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 3.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex