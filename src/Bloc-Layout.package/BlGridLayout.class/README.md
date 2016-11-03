I layout elements in a rectangular grid.

All children of an element with GridLayout must use GridConstraints that allows users to configure how children are located within grid independently. 

A grid consists of cells that are separated by invisible lines. Each line is assigned to an index, meaning that a grid with N columns would have N+1 line. Indices lie in closed interval [ 1, N + 1 ]. 

Grid Layout supports fitContent, matchParent and exact resizing mode of the owner. Children are allowed to have fitContent and exact resizing modes. Because child's matchParent does not make sense in case of grid users should use #fill to declare that child should take all available cell's space.

By default grid layout does not specify how many columns and rows exist, instead it tries to compute necessary amount of columns or rows depending on amount of children. User can specify amount of columns or rows by sending columnCount: or rowCount: to an instance of grid layout.

Grid Layout supports spacing between cells which can be set sending cellSpacing: message.

Public API and Key Messages

- columnCount: aNumber to specify amount of columns
- rowCount: aNumber to specify amount of rows
- cellSpacing: aNumber to specify spacing between cells
- alignMargins  bounds of each element are extended outwards, according to their margins, before the edges of the resulting rectangle are aligned.
- alignBounds  alignment is made between the edges of each component's raw bounds

   BlGridLayout new
	columnCount: 2;
	rowCount: 3;
	cellSpacing: 10;
	alignMargins
 
Internal Representation and Key Implementation Points.

    Instance Variables
	alignmentMode:		<BlGridAlignmentMode>
	cellSpacing:		<Number>
	horizontalAxis:		<BlGridLayoutAxis>
	lastLayoutParamsHashCode:		<Number>
	orientation:		<BlGridOrientation>
	verticalAxis:		<BlGridLayoutAxis>


    Implementation Points