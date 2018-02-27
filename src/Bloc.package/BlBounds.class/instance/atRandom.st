accessing
atRandom
	"Return a random integer point within this bounds"
	<return: #Point>
	
	^ (self topLeft + (self width atRandom @ self height atRandom)) asIntegerPoint