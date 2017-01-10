initialization
on: anElement
	self input 
		ifNil: [ self input: anElement ] 
		ifNotNil: [ :anInput | anInput on: anElement ]