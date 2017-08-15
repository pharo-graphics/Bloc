accessing
addNode: aRenderingNode

	nodes ifNil: [ nodes := LinkedList new ].
	nodes add: aRenderingNode.
	
	aRenderingNode parent: self