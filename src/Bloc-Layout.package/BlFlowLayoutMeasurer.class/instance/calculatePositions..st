calculating
calculatePositions: theLines
	
	"theLines inject: 0 into: [ :totalBreadth :aLine |
		aLine startBreadth: totalBreadth.
		aLine children inject: 0 into: [ :totalLength :aChild |
			aChild startLength: totalLength.
			totalLength + aChild length + aChild spacingLength ].
		totalBreadth + aLine breadth ]"