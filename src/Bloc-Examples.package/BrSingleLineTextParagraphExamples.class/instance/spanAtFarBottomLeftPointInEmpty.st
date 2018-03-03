geometry - empty
spanAtFarBottomLeftPointInEmpty
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan