layout
measurementSpecFor: parentSpec usedSize: usedSize resizer: childResizer
	"I determinate what measurement specification my child should have
	based on parent's measurement spec and child's resizer property.
	
	parentSpec may have the following modes:
	 - At Most: parent's size can be at most as provided value 
	 - Exactly: parent's size equals provided value
	 - Unspecified: parent still has no idea how big it should be
	
	usedSize is a number describing how much child's size differs from parent one
		defined in parentSpec. usedSize can consist out of child's margin and/or
		parent's padding. Custom layouts may introduce more parameters that influence
		on final size of child.
	
	childResizer may be:
	 - Parent Match: meaning that child wants to be as big as parent is. It may also proportionally
	   depend on parent
	 - Wrap Content: child tries to be big enough to fit contained subnodes
	 - Exactly: child knows exactly how big it wants to be
	"
	<return: #BlMeasurementSpec>

	| size |
   size := 0 max: (parentSpec size - usedSize).
	^ parentSpec mode measurement: childResizer with: size