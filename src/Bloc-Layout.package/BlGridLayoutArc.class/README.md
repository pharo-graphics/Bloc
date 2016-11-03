I represent an association of span interval, associated value and validity flag.

I am used by grid layout instead of Dictionary of span <-> value key-value pair for performance reasons. 

Internal Representation and Key Implementation Points.

    Instance Variables
	span:		<Interval>
	valid:		<Boolean>
	value:		<BlMutableInteger>