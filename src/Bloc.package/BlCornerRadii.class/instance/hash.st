comparing
hash
	^ bottomLeft hash bitXor: (bottomRight hash bitXor: (topLeft hash bitXor: topLeft))