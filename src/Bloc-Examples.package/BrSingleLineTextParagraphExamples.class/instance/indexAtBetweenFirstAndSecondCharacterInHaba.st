geometry - haba
indexAtBetweenFirstAndSecondCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: self glyphWidth @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex