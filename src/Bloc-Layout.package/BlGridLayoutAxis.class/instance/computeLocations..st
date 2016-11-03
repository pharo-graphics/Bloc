computing locations
computeLocations: theLocations

	self hasWeights
		ifFalse: [ self solveLocations: theLocations ]
		ifTrue: [ self solveAndDistributeSpaceLocations: theLocations ].
		
	self isOrderPreserved
		ifTrue: [ ^ self ].
	
	theLocations withIndexDo: [ :location :index |
		theLocations at: index put: (location - theLocations first) ]