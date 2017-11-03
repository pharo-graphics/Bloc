examples
gridWith11Cells
	<gtExample>
	
	^ self grid
		addChildren: ((1 to: 11) collect: [:i | self cell ]);
		yourself