instance creation
yAxis
	"Return a vector that corresponds to y-axis"
	<return: #BlVector>
	
	^ yAxis ifNil: [ yAxis := self x: 0 y: 1 z: 0 ]