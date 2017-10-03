tests
elementTree
	<gtExample>
	| parent child subChild |

	parent := self element.
	parent size: 200@200.
	parent background: Color blue.
	
	child := self element.
	child size: 150@150.
	child background: Color red.
	
	subChild := self element.
	subChild size: 100@100.
	subChild background: Color green.
	
	child addChild: subChild.
	parent addChild: child.

	^ parent