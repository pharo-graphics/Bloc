geometry extent
computeExtent
	self
		extent:
			(self from max: self to) - (self from min: self to) + (self border stroke width * 4) asPoint