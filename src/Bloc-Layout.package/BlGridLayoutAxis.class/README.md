I represent a horizontal or vertical axis of grid layout.

I compute and cache locations of cells within grid along corresponding axis.
I use Bellman-Ford algorithm to solve a set of inequalities in order to distribute indices such that cells of different sizes could fit on the grid within its bounds. 
I'm also responsible for calculation of grid's size based on children and grid resizing mode.

Public API and Key Messages

- applyLayoutIn: entrance point used to launch layout computation process within provided size along axis
- locations returns (creates,  computes and caches) cell locations and sizes along axis and used by GridLayout during measure: and layout:  
- measure: determines grid's size based on cells and grid's resizing mode along axis

   BlGridLayoutAxis new
	horizontal: true
 
Internal Representation and Key Implementation Points.

	Most instance variables are used to cache and store computation results between layout processes. Used to increase performance

    Instance Variables
	arcs:		<Object>
	arcsValid:		<Object>
	backwardLinks:		<Object>
	backwardLinksValid:		<Object>
	definedCount:		<Object>
	deltas:		<Object>
	element:		<Object>
	forwardLinks:		<Object>
	forwardLinksValid:		<Object>
	groupBounds:		<Object>
	groupBoundsValid:		<Object>
	hasWeights:		<Object>
	hasWeightsValid:		<Object>
	isHorizontal:		<Object>
	leadingMargins:		<Object>
	leadingMarginsValid:		<Object>
	locations:		<Object>
	locationsValid:		<Object>
	maxIndex:		<Object>
	orderPreserved:		<Object>
	parentMax:		<Object>
	parentMin:		<Object>
	trailingMargins:		<Object>
	trailingMarginsValid:		<Object>