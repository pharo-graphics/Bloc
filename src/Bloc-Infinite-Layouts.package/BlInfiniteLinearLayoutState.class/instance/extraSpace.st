accessing
extraSpace
	"Used if you want to pre-layout items that are not yet visible.
	The difference with availableSpace is that, when recycling, distance laid out for
   extraSpace is not considered to avoid recycling visible children"
	<return: #Number>
	
	^ extraSpace