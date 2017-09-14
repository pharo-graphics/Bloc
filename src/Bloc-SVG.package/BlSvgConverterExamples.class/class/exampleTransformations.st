transformation example
exampleTransformations
	|string|
	string:='<svg width="1200" height="550" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
					<defs>
						<rect id="MyRectangle" x="0" y="0" height="100" width="200"
							style="fill: red; stroke: white; stroke-width:2"/>
					</defs>
					
					<use id="NormalRectangle" xlink:href="#MyRectangle" x="10" y="50"/>
					<text x="90" y="160" fill="white"> Normal </text>
					<use id="TranslatedRectangle" xlink:href="#MyRectangle" x="320" y="50"
						transform="translate(0,20)"/>
					<text x="390" y="180" fill="white"> Translation </text>
					<use id="RotatedRectangle" xlink:href="#MyRectangle" x="630" y="50"
						transform="rotate(15,730,60) translate(15)"/>
					<text x="700" y="180" fill="white"> Rotation </text>	
						
					<use id="ScaledRectangle" xlink:href="#MyRectangle" x="10" y="300"
						transform="scale(1.2,1.2)"/>
					<text x="90" y="430" fill="white"> Scaling </text>	
					<use id="SkewedXRectangle" xlink:href="#MyRectangle" x="320" y="300"
						transform="skewX(15)"/>
					<text x="420" y="410" fill="white"> Skewing X </text>	
					<use id="SkewedYRectangle" xlink:href="#MyRectangle" x="630" y="300"
						transform="skewY(15)"/>
					<text x="700" y="440" fill="white"> Skewing Y </text>
						
					<use id="MatrixTransformedRectangle" xlink:href="#MyRectangle" x="900" y="110"
						transform="matrix(1.2,0.5,0.2,1.2,20,20)"/>
					<text x="1000" y="380" fill="white"> Matrix Transformation </text>
				</svg>'.
	
	self exampleFromString: string.