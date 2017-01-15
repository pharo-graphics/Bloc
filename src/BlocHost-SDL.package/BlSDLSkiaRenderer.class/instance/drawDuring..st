drawing
drawDuring: aBlock
	"self dirtyAreas do: [ :aRectangle |
		skiaCanvas clip
			by: aRectangle
			during: [ aBlock value: skiaCanvas ] ]."

	aBlock value: skiaCanvas