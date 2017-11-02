example
tabsGroup
	<gtExample>
	| tabs tab2 tab3 tab1 |
	
	tabs := BlInfiniteExamplePagerTabGroupElement new.
	tabs constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	tab1 := BlElement new
		size: 300@300;
		margin: (BlInsets all: 20);
		background: Color red.

	tab2 := BlElement new
		size: 300@300;
		margin: (BlInsets all: 20);
		background: Color blue.

	tab3 := BlElement new
		size: 400@400;
		margin: (BlInsets all: 20);
		background: Color green.

	tabs addTab: tab1 titled: 'Tab 1'.
	tabs addTab: tab2 titled: 'Tab 2'.
	tabs addTab: tab3 titled: 'Tab 3'.

	^ tabs