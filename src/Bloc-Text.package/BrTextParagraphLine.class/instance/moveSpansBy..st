private
moveSpansBy: aPoint
	"Move baseline of all spans by a given delta as a point"

	self spans do: [ :aSpan | aSpan baseline: aSpan baseline + aPoint ]