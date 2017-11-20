measurement
normalize: aScale
	"Normalize this segment to have rounded measurements"
	| newLeft newTop |

	newLeft := left floorTicks: aScale.
	newTop := top floorTicks: aScale.
	
	width := (left - newLeft + width) ceilingTicks: aScale.
	height := (top - newTop + height) ceilingTicks: aScale.
	
	left := newLeft.
	top := newTop.

	advance := advance ceilingTicks: aScale