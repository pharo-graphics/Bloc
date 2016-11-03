example
simple
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 50).
	nodes do: [ :node | node extent: (100 atRandom @ 100 atRandom) ].
	
	view addChildren: nodes.
	view layout: BlGraphRectanglePackLayout new.

	self applyLayoutIn: view.

	^ view