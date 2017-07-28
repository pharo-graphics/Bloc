accessing
opacity: aNumber
	"Change opacity of previously added background"
	
	self
		assert: [ backgrounds isNotEmpty ]
		description: [ 'There is no background to modify!' ].
		
	backgrounds last opacity: aNumber