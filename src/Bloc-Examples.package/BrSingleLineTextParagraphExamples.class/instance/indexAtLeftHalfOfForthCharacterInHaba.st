geometry - haba
indexAtLeftHalfOfForthCharacterInHaba
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 3) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 3.

	^ anIndex