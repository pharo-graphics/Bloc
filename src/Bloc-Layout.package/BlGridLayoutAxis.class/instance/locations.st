accessing
locations
	<return: #Array of: #Integer>

	locations ifNil: [
		locations := Array new: self count + 1 withAll: 0 ].
	
	locationsValid ifFalse: [ 
		self computeLocations: locations.
		locationsValid := true ].
	
	^ locations