accessing
baseline: aPoint

	self moveSpansBy: self baseline negated.
	super baseline: aPoint.
	self moveSpansBy: self baseline