accessing
flexibility
	^ (self alignment = BlGridAlignment undefined or: [ self hasWeight ])
		ifTrue: [ BlGridLayoutBounds inflexible ]
		ifFalse: [ BlGridLayoutBounds canStretch ]