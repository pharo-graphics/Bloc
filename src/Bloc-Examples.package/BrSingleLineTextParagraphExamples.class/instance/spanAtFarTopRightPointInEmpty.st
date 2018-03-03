geometry - empty
spanAtFarTopRightPointInEmpty
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) @ (self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan