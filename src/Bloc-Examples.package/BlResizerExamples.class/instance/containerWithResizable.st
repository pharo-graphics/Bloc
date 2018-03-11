instance creation
containerWithResizable
	<gtExample>
	| container resizable resizer |
	
	container := self container.
	
	resizable := self resizable.
	resizer := self resizer attachTo: resizable.
	
	container addChild: resizable as: #resizable.
	container addChild: resizer as: #resizer.
	
	^ container