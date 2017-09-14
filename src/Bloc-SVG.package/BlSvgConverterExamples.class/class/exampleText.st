shape examples
exampleText
	|string|
	string:='<svg height="150" width="150">
 			 		<text x="45" y="50" fill="red">
  						I love Bloc
						<tspan x="50" y="70">and SVG !</tspan>
					</text>
  				</svg> '.
	
	self exampleFromString: string.