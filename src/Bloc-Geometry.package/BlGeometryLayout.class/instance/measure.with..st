measure
measure: anElement with: anExtentSpec
	| maxExtent maxWidth maxHeight |
	
	"By definition geometry layout relies on element's geometry bounds
	and does not take children into account.
	We can optimise children measurement and complete everything in just one pass"
	maxExtent := anElement geometryBounds extent.
	maxWidth := maxExtent x.
	maxHeight := maxExtent y.
	
	maxWidth := maxWidth.
	maxHeight := maxHeight.
	
	maxWidth := maxWidth min: anElement constraints maxWidth.
	maxHeight := maxHeight min: anElement constraints maxHeight.
	maxWidth := maxWidth max: anElement constraints minWidth.
	maxHeight := maxHeight max: anElement constraints minHeight.

	anElement measuredExtent: (anExtentSpec sizeFor: maxWidth @ maxHeight).
	
	self measureChildren: anElement with: anExtentSpec