geometry extent
computeExtent
	self
		extent:
			(self from max: self to) - (self from min: self to) + (self border width * 4) asPoint