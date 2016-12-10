initialization
redAt: anIndex
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	(radians between: Float pi / 2.0 and: Float pi) 
		ifTrue: [ ^ 0 ].

	radians < (Float pi/ 2.0)
		ifTrue: [ ^ (radians + (Float pi / 2)) sin ].

	^ (radians + Float pi) sin