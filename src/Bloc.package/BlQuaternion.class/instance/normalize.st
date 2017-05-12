converting
normalize
	"Normalize me in-place"
	| length |
	
	length := self length.
	
	"length is 1, no need to normalize"
	(length closeTo: 1.0)
		ifTrue: [ ^ self ].
	
	length isZero
		ifTrue: [ 
			self x: 0.0 y: 0.0 z: 0.0 w: 1.0 ]
		ifFalse: [
			self x: x / length y: y / length z: z / length w: w / length ]