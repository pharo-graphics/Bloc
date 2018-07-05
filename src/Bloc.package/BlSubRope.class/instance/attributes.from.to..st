rope - accessing
attributes: anAttributesCollection from: aStart to: anEnd
	| anAttributeRope |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].

	anAttributeRope := self rope attributes: anAttributesCollection from: aStart + offset to: anEnd + offset.
	
	^ anAttributeRope from: offset + 1 to: offset + length