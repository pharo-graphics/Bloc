path examples
exampleCurveCubicBezier
	|string|
	string:='<svg width="500" height="400">	
					<path d="M100,200 C100,100 250,100 250,200 S400,300 400,200"
						style="fill:none; stroke:red; stroke-width:5"/>
				</svg>'.
	self exampleFromString: string.