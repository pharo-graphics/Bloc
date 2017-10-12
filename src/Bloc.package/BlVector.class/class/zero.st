instance creation
zero
	"Return a vector of zero length"
	<return: #BlVector>
	
	^ zero ifNil: [ zero := self x: 0 y: 0 z: 0 ]