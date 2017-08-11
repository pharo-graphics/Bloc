formatting
addAttributes: attributes forNode: anRBNode
	
	"RB bug?"
	(anRBNode start > anRBNode stop)
		ifTrue: [ ^ self ].
	
	self 
		addAttributes: attributes
		from: anRBNode start
		to: anRBNode stop