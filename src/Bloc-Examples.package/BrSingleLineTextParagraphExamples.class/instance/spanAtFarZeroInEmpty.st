geometry - empty
spanAtFarZeroInEmpty
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan