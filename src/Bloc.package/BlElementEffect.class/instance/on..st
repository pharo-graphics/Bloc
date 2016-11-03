initialization
on: aNode
	self input 
		ifNil: [ self input: aNode ] 
		ifNotNil: [ :in | in on: aNode ]