accessing
geometry
	"Return my current geometry used to clip/fill/stroke me and to clip my children during drawing.
	geometry can not be nil."
	<return: #BlGeometry>
	self assert: geometry isNotNil.
	^ geometry