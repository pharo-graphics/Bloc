vector functions
clockwiseEdges
	<return: #Collection of: #BlRay>

	^ { 
		BlRay from: self topLeft directed: (self topRight - self topLeft) asBlocVector.
		BlRay from: self topRight directed: (self bottomRight - self topRight) asBlocVector.
		BlRay from: self bottomRight directed: (self bottomLeft - self bottomRight) asBlocVector.
		BlRay from: self bottomLeft directed: (self topLeft - self bottomLeft) asBlocVector.
	}