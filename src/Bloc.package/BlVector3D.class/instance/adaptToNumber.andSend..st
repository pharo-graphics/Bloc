converting
adaptToNumber: aNumber andSend: aSelector
	"If I am involved in arithmetic with an Integer, convert it to a Vector of the same dimension"
	<return: #BlVector>

	^ (BlVector x: aNumber y: aNumber z: aNumber) perform: aSelector with: self