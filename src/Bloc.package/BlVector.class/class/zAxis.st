instance creation
zAxis
	"Return a vector that corresponds to z-axis"
	<return: #BlVector>
	
	^ zAxis ifNil: [ zAxis := BlUnitVector x: 0 y: 0 z: 1 ]