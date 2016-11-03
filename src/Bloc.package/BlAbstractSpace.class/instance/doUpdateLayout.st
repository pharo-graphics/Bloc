pulse
doUpdateLayout
	|done |
	"Start layouting process"
	"first we measure.."
	done := false.
	
	self root measure: (BlExtentMeasurementSpec new
		widthSpec: (self  root
			measurementSpecFor: (BlMeasurementSpec new beExact: self width)
			usedSize:  0
			resizer: BlLayoutMatchParentResizer new);
		heightSpec: (self root
			measurementSpecFor: (BlMeasurementSpec new beExact: self height)
			usedSize:  0
			resizer: BlLayoutMatchParentResizer new)).
	"...then we layout in measured on previous step bounds"
	self root applyLayoutIn: (0@0 extent: self extent).
	done := true.
	