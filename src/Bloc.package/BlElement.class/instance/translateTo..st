geometry transform
translateTo: factor
	self invalidate.
	self transform translation:factor.
	self changed