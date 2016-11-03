I define characteristics of a group of cells on the grid (indices, weight and alignment) along corresponding axis.

I am supposed to be immutable. In order to create a new spec with different parameters use provided copyWith*: methods

Public API and Key Messages

- span, declares indices on the grid. span first is an index of a row or column that cell wants to occupy.
- weight, proportional weight allowing to distribute cells proportionally. In order to work all cells in a group must have weight > 0.
- alignment, specifies how cells should be aligned within row or column groups.
- flexibility, dynamically determined based on current alignment and weight
- startDefined, true if span first is undefined. Means that it is up to grid to determine indices

	BlGridLayoutSpec new
		setAlignment: BlGridAlignment fill
		span:  (1 to: 2)
		startDefined:  true
		weight: 1
 
Internal Representation and Key Implementation Points.

    Instance Variables
	alignment:		<BlGridAlignment>
	span:		<Interval>
	startDefined:		<Boolean>
	weight:		<Number>