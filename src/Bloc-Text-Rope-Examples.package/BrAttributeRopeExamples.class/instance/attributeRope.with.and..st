attribute rope - examples
attributeRope: aRope with: leftAttributes and: rightAttributes
	<gtExample>
	<dependsOn: #simpleRope>
	<dependsOn: #attributesLeft>
	<dependsOn: #attributesRight>
	| attributeRope |

	attributeRope := aRope attributes: leftAttributes from: 1 to: (aRope size / 2) rounded - 1.
	attributeRope := attributeRope attributes: rightAttributes from: (aRope size / 2) rounded to: aRope size.
	
	self assert: attributeRope isConcatenation.
	self deny: attributeRope left isLeaf.
	self deny: attributeRope right isLeaf.
	self assert: attributeRope size equals: aRope size.
	self assert: attributeRope asString equals: aRope asString.
	
	^ attributeRope