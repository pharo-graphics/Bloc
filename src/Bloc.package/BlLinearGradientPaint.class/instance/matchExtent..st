geometry
matchExtent: anExtent
	| aDirection aStart anEnd aDelta aScaleX aScaleY |
	
	anExtent isZero
		ifTrue: [ ^ self ].
	
	aDirection := (self end - self start) normalized.
	
	aStart := 0@0.
	anEnd := aStart + (anExtent * aDirection).
	
	aScaleX := (anEnd x isZero
		ifTrue: [ 1.0 ]
		ifFalse: [ anExtent x / anEnd x ]) abs.
	aScaleY := (anEnd y isZero
		ifTrue: [ 1.0 ]
		ifFalse: [ anExtent y / anEnd y ]) abs.
	anEnd := anEnd * (aScaleX @ aScaleY).
	
	aDelta := anEnd min: aStart.

	self start: aStart - aDelta.
	self end: anEnd - aDelta