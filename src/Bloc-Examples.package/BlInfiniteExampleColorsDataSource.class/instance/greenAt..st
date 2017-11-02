initialization
greenAt: anIndex
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians > Float pi
		ifTrue: [ ^ 0 ].
	^ radians sin