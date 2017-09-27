initialization
initialize
	super initialize.
	
	panes := OrderedCollection new.
	panes add: (BlInfiniteExamplePagerPane new title: 'Pane 1').
	panes add: (BlInfiniteExamplePagerPane new title: 'Pane 2').
	panes add: (BlInfiniteExamplePagerPane new title: 'Pane 3').
	panes add: (BlInfiniteExamplePagerPane new title: 'Pane 4').