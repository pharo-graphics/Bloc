geometry
offsetCandidateBounds: aCandidateBounds according: aFocusedBounds
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	aCandidateBounds
		translateX: 0
		Y: aFocusedBounds height + 1