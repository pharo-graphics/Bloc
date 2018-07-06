example - attributes
removeDuplicates
	<gtExample>
	| firstDuplicate secondDuplicate theOriginalAttributes theAttributesWithoutDuplicates |

	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.
	
	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.
	
	theOriginalAttributes := { firstDuplicate . 1 . 2 . 3 . secondDuplicate }.
	theAttributesWithoutDuplicates := BlAttributeRope removeDuplicates: theOriginalAttributes.
	
	self assert: theAttributesWithoutDuplicates equals: { 1 . 2 . 3 . secondDuplicate }.
	
	^ theAttributesWithoutDuplicates