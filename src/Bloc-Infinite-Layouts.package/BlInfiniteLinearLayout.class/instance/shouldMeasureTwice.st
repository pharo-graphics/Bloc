testing
shouldMeasureTwice
	^ self heightSpec isExact not and: [ 
		self widthSpec isExact not and: [ 
			self hasFlexibleChildInBothOrientations ] ]