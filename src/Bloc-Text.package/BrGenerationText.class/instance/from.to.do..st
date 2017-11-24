instance creation
from: aFromIndex to: aToIndex do: aBlock
	"Evaluate aBlock with every character as argument within interval [aFromIndex, aToIndex]"
	
	self text from: aFromIndex to: aToIndex do: aBlock