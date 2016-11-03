as yet unclassified
on: aNode

	aNode isRoot
		ifTrue: [ ^ self ].
	self client: aNode.
	self show