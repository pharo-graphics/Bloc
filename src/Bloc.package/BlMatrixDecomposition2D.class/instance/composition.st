matrix - mathematical functions
composition
	<return: #BlMatrix2D>
	| composedMatrix |
	
	composedMatrix := BlMatrix2D new.
	composedMatrix sx: (matrix at: 1 at: 1).
	composedMatrix shy: (matrix at: 1 at: 2).
	composedMatrix shx: (matrix at: 2 at: 1).
	composedMatrix sy: (matrix at: 2 at: 2).
	
	"Translate matrix"
	composedMatrix x: (translation x * composedMatrix sx) + (translation y * composedMatrix shx).
	composedMatrix y: (translation x * composedMatrix shy) + (translation y * composedMatrix sy).
	
	"rotate matrix"
	composedMatrix := (BlMatrix2D rotation: angle degreesToRadians) multiplyBy: (composedMatrix).

	"Scale matrix."
	composedMatrix sx: composedMatrix sx * scale x.
	composedMatrix shy: composedMatrix shy * scale x.
	composedMatrix shx: composedMatrix shx * scale y.
	composedMatrix sy: composedMatrix sy * scale y.
	
	^ composedMatrix