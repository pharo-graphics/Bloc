accessing
targetSeekExtraScrollRatio
	"Trigger a scroll to a further distance than targetSeekScrollDistance so that if target
	element is not laid out until interim target position is reached, we can detect the case before
	scrolling slows down and reschedule another interim target scroll"
	<return: #Number>

	^ 1.2