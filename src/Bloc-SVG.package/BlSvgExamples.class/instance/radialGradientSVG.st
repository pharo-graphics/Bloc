svg - string
radialGradientSVG
	<gtExample>

	^ '<svg width="240" height="200">
			<radialGradient id="MyGradient">
				<stop offset="0.0" stop-color="yellow" />
				<stop offset="1.0" stop-color="red" />
			</radialGradient>			
			<rect x="20" y="50" height="100" width="200" rx="20" ry="20" style="fill: url(#MyGradient);"/>
		</svg>'