geometry - empty
spanAtFarTopPointInEmpty
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@(self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan