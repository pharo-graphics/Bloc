rope - accessing
attributes: anAttributesCollection from: aStart to: anEnd
	| anAttributeRope |
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	anAttributesCollection
		ifEmpty: [ ^ self ].
	
	anAttributeRope := self class attributeRope
		attributes: anAttributesCollection
		rope: (self from: aStart to: anEnd).
		
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].
		
	aStart = 1 ifTrue: [ 
		^ anAttributeRope append: (self from: anEnd + 1 to: self size) ].
	
	anEnd = self size ifTrue: [ 
		^ (self from: 1 to: aStart - 1) append: anAttributeRope ].
	
	^  (self from: 1 to: aStart - 1) append: (anAttributeRope append: (self from: anEnd + 1 to: self size))