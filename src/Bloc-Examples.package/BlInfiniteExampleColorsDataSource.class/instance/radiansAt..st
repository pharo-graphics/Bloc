initialization
radiansAt: anIndex
	"0.0 <= anIndex <= 1.0"
	self assert: [ anIndex between: 0.0 and: 1.0 ].
	
	^ anIndex * (Float pi * 3) / 2.0