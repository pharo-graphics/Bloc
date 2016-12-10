children - accessing
firstReferenceChild
	<return: #BlElement or: nil>

	^ self
		referenceChildWithin: (1 to: self childrenCount)
		between: (1 to: self state itemCount)