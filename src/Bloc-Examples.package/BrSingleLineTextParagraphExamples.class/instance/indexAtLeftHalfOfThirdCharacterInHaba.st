geometry - haba
indexAtLeftHalfOfThirdCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 2) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 2.

	^ anIndex