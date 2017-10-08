instance creation
xAxis
	"Return a vector that corresponds to x-axis"
	<return: #BlVector>
	
	^ xAxis ifNil: [ xAxis := BlUnitVector x: 1 y: 0 z: 0 ]