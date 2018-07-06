example - attributes
mergeAttributes
	<gtExample>
	| firstDuplicate secondDuplicate theOriginalAttributes theAddedAttributes theAttributesWithoutDuplicates |

	"they are equal but not identical"
	firstDuplicate := String fromString: 'Haba'.
	secondDuplicate := String fromString: 'Haba'.
	
	self assert: firstDuplicate equals: secondDuplicate.
	self assert: (firstDuplicate == secondDuplicate) not.
	
	theOriginalAttributes := { firstDuplicate . 1 . 2  }.
	theAddedAttributes := { 3 . secondDuplicate }.
	
	theAttributesWithoutDuplicates := BlAttributeRope mergeAttributes: theOriginalAttributes and: theAddedAttributes.
	
	self assert: theAttributesWithoutDuplicates equals: { 1 . 2 . 3 . secondDuplicate }.
	
	^ theAttributesWithoutDuplicates