geometry transform
rotateByRadians: anAngle 
	self 
		deprecated: 'Use rotateByDegrees: instead'
		on: 	'16 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
	^ self rotateByDegrees: anAngle radiansToDegrees