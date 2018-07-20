examples - attributes
clearAttributesOnEmptyRope
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |
	
	anEmptyRope := self small_empty.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: aRopeWithoutAttributes isEmpty.
	self assert: aRopeWithoutAttributes == anEmptyRope.

	^ aRopeWithoutAttributes