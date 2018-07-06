examples - spans
spansInAttributeRope
	<gtExample>
	| anAttributeRope iterator leftSpan rightSpan |
	
	anAttributeRope := self attributeRopeWithLeftAndRight.
	iterator := anAttributeRope iterator.
	leftSpan := iterator nextSpan.
	rightSpan := iterator nextSpan.
	
	"the beauty of rope's implementation: if spans go one after each other without
	overlapping (which often happens in case of syntax highlighting) their enumeration does
	not produce new objects and instead returns references to existing ones"
	self assert: anAttributeRope left == leftSpan.
	self assert: anAttributeRope right == rightSpan.
	
	^ { leftSpan . rightSpan }