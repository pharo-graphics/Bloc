bounds
starWithSmallerGeometry
	<gtExample>
	| aStarElement |
	
	aStarElement := BlElement new.
	aStarElement geometry: (BlPolygon vertices: {(100@50). (115@90). (150@90). (125@110). (135@150). (100@130). (65@150). (75@110). (50@90). (85@90)}).
	aStarElement size: 200@200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	aStarElement outskirts: BlOutskirts centered.
	
	^ aStarElement