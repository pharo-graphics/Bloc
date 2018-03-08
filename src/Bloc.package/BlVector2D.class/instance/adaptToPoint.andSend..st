converting
adaptToPoint: aPoint andSend: aSelector
	"If I am involved in arithmetic with an Point, convert me to a point and perform that operation"
	<return: #Point>

	^ aPoint perform: aSelector with: self asPoint