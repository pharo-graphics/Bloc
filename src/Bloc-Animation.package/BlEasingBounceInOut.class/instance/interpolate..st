interpolation
interpolate: aProgress
	aProgress <= 0.5
		ifTrue: [ ^ (self computeBounce: 2 * aProgress) / 2 ].
	^ (2 - (self computeBounce: 2 * (1 - aProgress))) / 2