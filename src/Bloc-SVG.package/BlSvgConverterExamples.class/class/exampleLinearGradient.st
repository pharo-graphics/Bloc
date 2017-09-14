definitions examples
exampleLinearGradient
	|string|
	string:='<svg width="240" height="200">
					<linearGradient id="MyGradient" x2="100" y2="100">
        				<stop offset="0.0" stop-color="yellow" />
						<stop offset="1.0" stop-color="red" />
      				</linearGradient>
					
					<rect x="20" y="50" height="100" width="200" rx="20" ry="20"
						style="fill: url(#MyGradient);"/>
				</svg>'.
	
	self exampleFromString: string.