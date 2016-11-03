computing deltas
deltas
	^ deltas ifNil: [ 
		deltas := Array new: self element childrenCount withAll: 0 ]