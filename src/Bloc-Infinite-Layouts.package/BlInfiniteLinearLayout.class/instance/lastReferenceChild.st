children - accessing
lastReferenceChild
	<return: #BlElement or: nil>

	^ self
		referenceChildWithin: (self childrenCount to: 1)
		between: (1 to: self state itemCount)