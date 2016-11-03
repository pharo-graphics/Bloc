geometry
excessBreadth
	^ self totalBreadth - (self lines inject: 0 into: [ :aTotalBreadth :aLine | aTotalBreadth + aLine breadth ] )