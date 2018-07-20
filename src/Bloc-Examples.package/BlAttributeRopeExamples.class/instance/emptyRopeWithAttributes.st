instance creation
emptyRopeWithAttributes
	| aRope |
	<gtExample>

	aRope := BlCollectionRope empty attributes: { 1 }.
	self assert: aRope rope == BlCollectionRope empty.
	
	^ aRope