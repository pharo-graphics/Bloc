path examples
examplePathTree
	|string|
	string:='<svg height="600" width="600">
					<g transform="scale(0.3,0.3)" style="stroke:green;fill:lime;stroke-width:10;">
						<path d="M1000,200 Q950,400 800,500 Q600,600 750,650 T700,850 Q400,1100 600,1100 T500,1400   Q250,1600 450,1600 L850,1600 Q950,1600 950,1700 h95"/>
  						<path d="m 1041.1111,1700 q 0,-100 100,-100 l 400,0 q 200,0 -50,-200 -300,-300 -100,-300 200,0 -100,-250 -200,-150 -50,-200 150,-50 -50,-150 -150,-100 -200,-300"/>
					</g>
				</svg>'.
	
	self exampleFromString: string.
					''