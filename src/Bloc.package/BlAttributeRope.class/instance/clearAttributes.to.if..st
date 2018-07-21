rope - accessing
clearAttributes: aStart to: anEnd if: aBlock
	| aClearedRope selectedAttributes aSubRope aSubRopeStart aSubRopeEnd aMyStart aMyEnd |
	self assertAccessFrom: aStart to: anEnd.

	selectedAttributes := self attributes reject: [ :anAssociation | aBlock value: anAssociation value ].

	aSubRope := self rope from: aStart to: anEnd.
	aSubRopeStart := (1 min: aSubRope size).
	aSubRopeEnd := anEnd - aStart + (1 min: aSubRope size).
	
	aMyStart := 1 min: self size.
	aMyEnd := self size.
	
	aClearedRope := aSubRope
		clearAttributes: aSubRopeStart
		to: aSubRopeEnd
		if: aBlock.

	selectedAttributes ifNotEmpty: [ 
		aClearedRope := aClearedRope
			attributes: selectedAttributes
			from: aSubRopeStart
			to: aSubRopeEnd ].

	(aStart = aMyStart and: [ anEnd = aMyEnd ])
		ifTrue: [ ^ aClearedRope ].

	aStart = aMyStart ifTrue: [ 
		^ self class
			concatenate: aClearedRope
			and: (self from: anEnd + 1 to: aMyEnd) ].
	
	anEnd = self size ifTrue: [ 
		^ self class
			concatenate: (self from: 1 to: aStart - 1)
			and: aClearedRope ].

	^ (self from: 1 to: aStart - 1) append: (aClearedRope append: (self from: anEnd + 1 to: self size))