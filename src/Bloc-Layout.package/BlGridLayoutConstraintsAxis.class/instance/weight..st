accessing
weight: aNumber
	"Set cell's weight along corresponding axis. Only positive
	weight (> 0) is taken into account. In order reset/disable
	flexible cell distribution set weight to 0.
	aNumber must be equal or greater than 0"
	self assert: aNumber isNotNil.
	self assert: aNumber >= 0.

	spec := self spec copyWithWeight: aNumber