pulse
valueForStep: aDelta
	| aValue |
	
	aValue := (to - from) * aDelta + from.
	^ by
		ifNil: [ aValue ]
		ifNotNil: [ (aValue / by) floor * by ]