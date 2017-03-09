paragraph - geometry
height
	"Return measured height of the paragraph.
	Note: height may be greater than maxHeight. This may happen
	if maxHeight is smaller than height of a single line or word or character.
	We want to guarantee that at least something is displayed and measured."
	<return: #Number>

	^ height