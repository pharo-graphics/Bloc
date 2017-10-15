instance creation
xAxis
	"Return a vector that corresponds to x-axis"
	<return: #BlVector>
	
	^ xAxis ifNil: [ xAxis := self x: 1 y: 0 z: 0 ]