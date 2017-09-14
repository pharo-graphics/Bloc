shape examples
exampleCircle
	|string|
	string:='<svg width="450" height="150">
					<circle cx="75" cy="75" r="50"
						style="fill: firebrick; stroke: goldenrod; stroke-width: 5; stroke-dasharray: 10,5" />
					<circle cx="225" cy="75" r="50"
						style="fill: navy"/>
					<circle cx="375" cy="75" r="50"
						style="fill: green; stroke: silver; stroke-width: 5" />
				</svg>'.
	
	self exampleFromString: string.