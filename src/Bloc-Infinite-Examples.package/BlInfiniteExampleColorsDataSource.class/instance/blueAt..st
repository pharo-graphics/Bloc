initialization
blueAt: anIndex
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians < (Float pi / 2.0)
		ifTrue: [ ^ 0 ].
	^ (radians - (Float pi / 2.0)) sin