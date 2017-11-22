examples
exampleClassesMultiple
	| dataSource space1 list1 space2 list2 |
	
	dataSource := BlInfiniteExampleClassesDataSource new.

	list1 := BlInfiniteExampleElement new
		dataSource: dataSource;
		background: Color paleBlue;
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	space1 := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses (1)'.
	space1 root addChild: list1.
	
	list2 := BlInfiniteExampleElement new
		dataSource: dataSource;
		background: Color paleRed;
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	space2 := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses (2)'.
	space2 root addChild: list2.
	
	
	space1 show.
	space2 show.