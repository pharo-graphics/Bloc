rectangle and start
container
	<gtExample>
	<label: 'A container for the rectangle and the star'>
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: (BlGridLayout horizontal cellSpacing: 20).
	aContainer margin: (BlInsets all: 10).
	aContainer padding: (BlInsets all: 10).
	aContainer constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	^ aContainer