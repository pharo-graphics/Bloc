examples - attributes
attributesOnEmptyRope
	<gtExample>
	| anEmptyRope anAttributedRope |
	
	anEmptyRope := self small_empty.
	anAttributedRope := anEmptyRope attributes: { 1 }.

	self assert: anAttributedRope isEmpty.
	self assert: anAttributedRope rope == anEmptyRope.
	self assert: anAttributedRope attributes equals: { 1 }.
	
	^ anAttributedRope