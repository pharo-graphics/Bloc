svg - string
transformationsSVG
	<gtExample>

	^ '<svg width="1200" height="550" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
			<defs>			
				<rect id="MyRectangle" x="20" y="50" height="100" width="200" style="fill: darkorange; stroke: red; stroke-width: 3"/>
			</defs>
					
			<use id="NormalRectangle" xlink:href="#MyRectangle" x="10" y="50"/>
			<text id="Text:Normal" x="90" y="160" fill="red"> Normal </text>
			<use id="TranslatedRectangle" xlink:href="#MyRectangle" x="320" y="50" transform="translate(0,20)"/>
			<text id="Text:Translation" x="390" y="180" fill="red"> Translation </text>
			<use id="RotatedRectangle" xlink:href="#MyRectangle" x="630" y="50" transform="rotate(15,730,60) translate(15)"/>
			<text id="Text:Rotation" x="700" y="180" fill="red"> Rotation </text>	
						
			<use id="ScaledRectangle" xlink:href="#MyRectangle" x="10" y="300" transform="scale(1.2,1.2)"/>
			<text id="Text:Scaled" x="90" y="430" fill="red"> Scaling </text>	
			<use id="SkewedXRectangle" xlink:href="#MyRectangle" x="320" y="300" transform="skewX(15)"/>
			<text id="Text:SkewedX" x="420" y="410" fill="red"> Skewing X </text>	
			<use id="SkewedYRectangle" xlink:href="#MyRectangle" x="630" y="300" transform="skewY(15)"/>
			<text id="Text:SkewedY" x="700" y="440" fill="red"> Skewing Y </text>
						
			<use id="MatrixTransformedRectangle" xlink:href="#MyRectangle" x="900" y="110" transform="matrix(1.2,0.5,0.2,1.2,20,20)"/>
			<text id="Text:MatrixTransformed" x="1000" y="380" fill="red"> Matrix Transformation </text>
		</svg>'