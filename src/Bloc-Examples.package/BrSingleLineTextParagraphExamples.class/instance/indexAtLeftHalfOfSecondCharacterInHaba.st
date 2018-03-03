geometry - haba
indexAtLeftHalfOfSecondCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 1) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex