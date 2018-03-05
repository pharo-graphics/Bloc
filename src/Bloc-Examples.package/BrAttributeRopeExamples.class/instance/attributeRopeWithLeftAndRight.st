attribute rope - examples
attributeRopeWithLeftAndRight
	<gtExample>
	| aRope leftAttributes rightAttributes attributeRope |

	aRope := self simpleRope.
	leftAttributes := self attributesLeft.
	rightAttributes := self attributesRight.

	attributeRope := aRope attributes: leftAttributes from: 1 to: (aRope size / 2) rounded - 1.
	attributeRope := attributeRope attributes: rightAttributes from: (aRope size / 2) rounded to: aRope size.
	
	self assert: attributeRope isConcatenation.
	self assert: attributeRope left isLeaf not.
	self assert: attributeRope right isLeaf not.
	self assert: attributeRope size equals: aRope size.
	self assert: attributeRope asString equals: aRope asString.
	
	^ attributeRope