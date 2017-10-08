instance creation
yAxis
	"Return a vector that corresponds to y-axis"
	<return: #BlVector>
	
	^ yAxis ifNil: [ yAxis := BlUnitVector x: 0 y: 1 z: 0 ]