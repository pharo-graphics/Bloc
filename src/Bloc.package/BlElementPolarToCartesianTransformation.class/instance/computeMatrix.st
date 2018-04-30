computation
computeMatrix
	| polarR polarPhi cartesianX cartesianY |

	polarR := self owner position x.
	polarPhi := self owner position y.
	
	cartesianX := polarR * polarPhi degreesToRadians cos.
	cartesianY := polarR * polarPhi degreesToRadians sin negated.

	matrix translateBy: (BlVector x: cartesianX - polarR y: cartesianY - polarPhi )

	"matrix := BlMatrix2D new
		sx: self owner position y cos;
		shx: self owner position x negated * self owner position y sin;
		sy: self owner position x * self owner position y cos;
		shy: self owner position y sin"