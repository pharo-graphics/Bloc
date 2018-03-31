examples - smooth scroll
smoothScrollDown
	<gtExample>
	| aFlinger |
	
	aFlinger := self scrollFlingerOnScrollPane.
	aFlinger smoothScrollBy: 0@500 during: 2 seconds.
	^ aFlinger scrollable