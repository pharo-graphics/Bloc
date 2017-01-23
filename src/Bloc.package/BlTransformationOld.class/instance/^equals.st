comparing
= anObject
	"Return true if I am equals to the given object, false otherwise"
	<return: #Boolean>

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ x = anObject x and: [ 
		y = anObject y and: [ 
			sx = anObject sx and: [ 
				sy = anObject sy and: [ 
					shx = anObject shx and: [ 
						shy = anObject shy ] ] ] ] ]