protected
measureChild: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed
	"Measure anElement based on provided parent's extent measurement specification and used width and height.
	used width and height can contain margin and/or padding.
	@see BlElement>>#measurementSpecFor:usedSize:resizing: for more info"

	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (self
			measurementSpecFor: parentSpec widthSpec
			usedSize: widthUsed
			resizer: anElement constraints horizontal resizer);
		heightSpec: (self
			measurementSpecFor: parentSpec heightSpec
			usedSize: heightUsed
			resizer: anElement constraints vertical resizer))