vector functions
counterClockwiseEdges
	<return: #Collection of: #BlRay>
	
	^ { 
		BlRay from: self topRight directed: (self topLeft - self topRight) asBlocVector.
		BlRay from: self topLeft directed: (self bottomLeft - self topLeft) asBlocVector.
		BlRay from: self bottomLeft directed: (self bottomRight - self bottomLeft) asBlocVector.		
		BlRay from: self bottomRight directed: (self topRight - self bottomRight) asBlocVector.
	}