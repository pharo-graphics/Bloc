evaluating
value: aFirstElement value: aSecondElement
	" I sort elements according to the following strategy:
	
	1) A rectangle that is located higher gets higher priority,
	so A will be higher in the sorted list than B:
	
	|----------|
	|    A     |       
	|__________|      
	
	|-----------|
	|     B     |
	|___________|
	
	2) A rectangle with smaller x coodinate of a left edge gets higher priority,
	A will be before B:
	Note: if layout is left to right, then B should be first (reversed order)
	
	|---------|  |---------|
	|    A    |  |    B    |
	|_________|  |_________|
	"
	