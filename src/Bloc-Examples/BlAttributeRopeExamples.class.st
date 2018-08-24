"
I contain examples of an attribute rope
"
Class {
	#name : #BlAttributeRopeExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #'examples - spans' }
BlAttributeRopeExamples >> attributeRopeWithLeftAndRight [
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
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> attributesLeft [
	<gtExample>

	^ { Color red . 'Foo' . 10 }
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> attributesRight [
	<gtExample>
	
	^ { Color blue . 'Bar' . 100 }
]

{ #category : #'example - attributes' }
BlAttributeRopeExamples >> clearAttributesFromEmpty [
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |

	anEmptyRope := self emptyRopeWithAttributes.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: (aRopeWithoutAttributes == BlCollectionRope empty).

	^ aRopeWithoutAttributes
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> emptyRopeWithAttributes [
	| aRope |
	<gtExample>

	aRope := BlCollectionRope empty attributes: { 1 }.
	self assert: aRope rope == BlCollectionRope empty.
	
	^ aRope
]

{ #category : #'example - attributes' }
BlAttributeRopeExamples >> mergeAttributes [
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
]

{ #category : #'example - attributes' }
BlAttributeRopeExamples >> removeDuplicates [
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
]

{ #category : #'instance creation' }
BlAttributeRopeExamples >> simpleRope [
	<gtExample>

	^ BlCollectionRope collection: 'Hello world!'
]

{ #category : #'examples - spans' }
BlAttributeRopeExamples >> spansInAttributeRope [
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
]
