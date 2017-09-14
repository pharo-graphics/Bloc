shape examples
exampleLine
	|string|
	string:='<svg width="420" height="210">
  					<line x1="10" y1="10" x2="200" y2="200"
						style="stroke: red; stroke-width: 2" />
					<line x1="210" y1="10" x2="400" y2="200"
						style="stroke: red; stroke-width: 2; stroke-dasharray: 10,10" />
				</svg>'.
	
	self exampleFromString: string.