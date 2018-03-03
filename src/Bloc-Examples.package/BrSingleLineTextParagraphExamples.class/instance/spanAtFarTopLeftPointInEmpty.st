geometry - empty
spanAtFarTopLeftPointInEmpty
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) asPoint negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan