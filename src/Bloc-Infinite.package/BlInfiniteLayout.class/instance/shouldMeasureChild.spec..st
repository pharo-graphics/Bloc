measurement - testing
shouldMeasureChild: anElement spec: anExtentSpec
	"Return true of a child element should be measured, false otherwise"
	<return: #Boolean>
	
	^ anElement isLayoutRequested or: [
		self shouldReMeasureChild: anElement spec: anExtentSpec ]