concatenation - examples
sizeOf: aConcatenationRope
	<gtExample>
	<dependsOn: #concatenate:with:>
	
	self
		assert: aConcatenationRope size
		equals: (aConcatenationRope left size + aConcatenationRope right size).
		
	^ aConcatenationRope size