text - accessing
from: aStart to: anEnd
	"Create and return a subtext of this text form aStart to anEnd.
	Note: All modifications that are happening to the subtext automatically
	applied on this original text"
	<return: #BrSubText>

	^ BrSubText text: self from: aStart to: anEnd