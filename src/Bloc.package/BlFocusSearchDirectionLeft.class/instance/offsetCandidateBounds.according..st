geometry
offsetCandidateBounds: aCandidateBounds according: aFocusedBounds
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	aCandidateBounds
		translateX: aFocusedBounds width + 1
		Y: 0