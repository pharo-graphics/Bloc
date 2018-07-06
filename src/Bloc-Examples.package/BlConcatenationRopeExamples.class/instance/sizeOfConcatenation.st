instance creation
sizeOfConcatenation
	<gtExample>
	| aConcatenationRope |
	
	aConcatenationRope := self concatenation.
	
	self
		assert: aConcatenationRope size
		equals: (aConcatenationRope left size + aConcatenationRope right size).
		
	^ aConcatenationRope size