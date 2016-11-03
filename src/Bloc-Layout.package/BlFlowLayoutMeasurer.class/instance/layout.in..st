layout
layout: anElement in: newBounds
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			| constraints left top width height |
			constraints := aChild element constraints.
			left := anElement padding left + aLine lineX + aChild inlineX + constraints margin left.
			top := anElement padding top + aLine lineY + aChild inlineY + constraints margin top.
			width := aChild width.
			height := aChild height.
			aChild element applyLayoutIn: (left @ top extent: width @ height) ] ]