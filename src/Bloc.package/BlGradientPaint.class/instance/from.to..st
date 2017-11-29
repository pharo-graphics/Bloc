initialization
from: aStartColor to: anEndColor
	"A convenience method to create a gradient consisting out of 2 colors"
	
	self stops: { 
		0 -> aStartColor.
		1 -> anEndColor
	}