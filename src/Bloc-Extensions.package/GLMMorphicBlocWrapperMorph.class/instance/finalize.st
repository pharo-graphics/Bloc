finalization
finalize
	self closeSpace.
	space at: 1 put: nil.
	currentWindow := nil