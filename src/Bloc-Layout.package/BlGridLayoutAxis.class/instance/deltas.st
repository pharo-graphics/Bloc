computing deltas
deltas
	^ deltas ifNil: [ 
		deltas := Array new: self element managedChildren size withAll: 0 ]