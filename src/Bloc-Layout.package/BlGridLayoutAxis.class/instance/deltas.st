computing deltas
deltas
	^ deltas ifNil: [ 
		deltas := Array new: self element children accountedByLayout size withAll: 0 ]