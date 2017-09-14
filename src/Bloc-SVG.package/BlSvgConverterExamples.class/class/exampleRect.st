shape examples
exampleRect
	|string|
	string:='<svg width="610" height="200">
					<rect x="10" y="50" height="100" width="200"
						style="fill: firebrick; stroke: goldenrod; stroke-width: 4; stroke-dasharray: 10,10 "/>
					<rect x="250" y="25" width="150" height="150"
  						style="fill: navy" />
					<rect x="450" y="25" rx="20" ry="20" width="150" height="150" 
						style="fill: green; stroke: silver; stroke-width: 5" />
				</svg>'.
	
	self exampleFromString: string.