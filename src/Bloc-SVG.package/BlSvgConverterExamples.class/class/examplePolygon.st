shape examples
examplePolygon
	|string|
	string:='<svg width="600" height="210">
 					<polygon points="100,10 40,198 190,78 10,78 160,198"
  						style="fill: firebrick; stroke: goldenrod; stroke-width: 2; stroke-dasharray: 10,10" />
					<polygon points="300,10 240,198 390,78 210,78 360,198"
  						style="fill: navy"/>
					<polygon points="500,10 440,198 590,78 410,78 560,198"
  						style="fill: green; stroke: silver; stroke-width: 3" />
				</svg> '.
				
	self exampleFromString: string.	