definitions examples
exampleUseSymbolRect
	|string|
	string:='<svg width="800" height="200" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
					<symbol id="MyRect">
						<rect x="00" y="00" height="100" width="200"
							style="fill: red; stroke: white; stroke-width: 4"/>
					</symbol>
					<use x="50" y="50" xlink:href="#MyRect" />
					<use x="300" y="50" xlink:href="#MyRect" />
					<use x="550" y="50" xlink:href="#MyRect" />
				</svg>'.
	
	self exampleFromString: string.