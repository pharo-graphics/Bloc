accessing
updateActionsPosition
	tlBtn position: 0 @ 0.
	trBtn position: (self width - trBtn width @ 0).
	blBtn position:  0@ (self height - blBtn height).
	brBtn position: self extent - (brBtn width @ brBtn height) .
	self changed