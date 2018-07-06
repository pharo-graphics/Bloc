rope - attributes
attributes: anAttributesCollection from: aStart to: anEnd
	| anAttributeRope |

	self assertAccessFrom: aStart to: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].
	
	"return an attributed rope of myself since we are empty"
	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self class attributeRope
		attributes: anAttributesCollection
		rope: self ].
	
	anAttributeRope := self class attributeRope
		attributes: anAttributesCollection
		rope: (self from: aStart to: anEnd).
	
	"attributes are applied on the whole rope, return it"
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].
		
	aStart = 1
		ifTrue: [ ^ anAttributeRope append: (self from: anEnd + 1 to: self size) ].
	
	anEnd = self size
		ifTrue: [ ^ (self from: 1 to: aStart - 1) append: anAttributeRope ].
	
	^  (self from: 1 to: aStart - 1) append: (anAttributeRope append: (self from: anEnd + 1 to: self size))