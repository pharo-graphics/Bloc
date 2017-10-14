instance creation
one
	"Return a vector with all components being ones"
	<return: #BlVector>
	
	^ one ifNil: [ one := self x: 1 y: 1 z: 1 ]