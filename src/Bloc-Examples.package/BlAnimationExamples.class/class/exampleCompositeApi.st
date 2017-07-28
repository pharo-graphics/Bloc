examples
exampleCompositeApi
	<example> 
	| sp el cAnim |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground paint: Color blue);
		extent: 100 @ 100;
		position: 100 @ 100.
	cAnim := BlSequentialAnimation new
		target: el;
		translate:[:t| t to: 300@300; duration: 500];
		scale:[:s|s scaleTo: 2@2; duration: 500];
		rotate:[:r| r angle: 360; duration:500];
		inParallelDo: [ :p|p
			scale:[:s|s scaleTo: (3@3); duration: 500];
			translate:[:t| t to:100@100;duration: 500]
			
			 ].
		
		
	sp root addChild: el.
	sp show.
	cAnim start