path examples
exampleCurveQuadraticBezier
	|string|
	string:='<svg width="500" height="400">
					<path d="M100,200 Q175,50 250,200 T400,200"
						style="fill:none; stroke:red; stroke-width:5"/>
				</svg>'.
	
	self exampleFromString: string.