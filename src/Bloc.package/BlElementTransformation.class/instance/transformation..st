accessing
transformation: anAffineTransformation

	owner invalidate.

	transformation := anAffineTransformation.
	self invalidateMatrix.
	
	owner invalidate