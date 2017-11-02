example
example
	<gtExample>
	| pager |
	pager := BlInfiniteExamplePager new.

	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	pager list dataSource
		addPane: (BlInfiniteExamplePagerPane new title: 'Tabs'; elementBlock: [ self tabsGroup ]);
		addPane: (BlInfiniteExamplePagerPane new
			title: 'Pane 1';
			elementBlock: [
				BlElement new
					size: 400@400;
					background: Color blue] );
		addPane: (BlInfiniteExamplePagerPane new
			title: 'Pane 2';
			elementBlock: [
				BlElement new
					constraintsDo: [:c |
						c horizontal matchParent .
						c vertical matchParent ];
					background: Color red]).
	^ pager