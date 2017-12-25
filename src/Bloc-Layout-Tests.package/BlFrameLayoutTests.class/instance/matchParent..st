instance creation
matchParent: aWeightPoint

	^ BlElement new
		background: Color indexedColors atRandom;
		border: (BlBorder builder paint: Color blue; width: 1; build);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal weight: aWeightPoint asPoint x.
			c frame vertical weight: aWeightPoint asPoint y ];
		yourself