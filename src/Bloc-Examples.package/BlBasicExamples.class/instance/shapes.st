examples - composition
shapes
	<gtExample>
	
	^ self container
		addChildren: { 
			self circle relocate: 250 @ 200.
			self ellipse relocate: 10 @ 20.
			self line.
			self polygon relocate: 220 @ 0.
			self rectangle relocate: 10 @ 190.
			self roundedRectangle relocate: 430 @ 50.
			self square relocate: 400 @ 200.
		}