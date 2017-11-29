geometry
matchExtent: anExtent
	
	self center: anExtent * (self center / 100.0) asFloatPoint.
	self focalPoint: anExtent * (self focalPoint / 100.0) asFloatPoint.
	self radius: (anExtent distanceTo: 0@0) * (self radius / 100.0) asFloat