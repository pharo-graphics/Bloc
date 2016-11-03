example
simple
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 75).
	view addChildren: nodes.
	view layout: (BlGraphCircleLayout new radius: 150).

	self applyLayoutIn: view.

	^ view