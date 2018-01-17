pulse
doUpdateLayout: anElement
	"Perform layout of a given element (e.g. root or glass)"

	"first we measure.."
	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec new beExact: self width)
			usedSize:  0
			resizer: BlLayoutResizer matchParent);
		heightSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec new beExact: self height)
			usedSize:  0
			resizer: BlLayoutResizer matchParent)).

	"...then we layout in measured during previous step bounds"
	anElement applyLayoutIn: anElement measuredBounds asRectangle.
	anElement commitChanges