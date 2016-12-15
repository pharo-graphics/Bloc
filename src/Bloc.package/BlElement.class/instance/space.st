accessing
space
	"Return space to which I belong. Direct reference boosts performance.
	Each element has a reference to the current space which is set at demand."
	<return: #BlSpace>
	
	space ifNotNil:[^ space].
	 self parent ifNotNil: [ :p | space := p space ].
	^ space