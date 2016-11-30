accessing
pool
	^ pool ifNil: [ pool := BlInfiniteSimplePool new: self poolSize ]