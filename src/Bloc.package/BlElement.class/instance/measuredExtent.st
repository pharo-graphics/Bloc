layout
measuredExtent
	"Return my measured extent used during layout by layout strategies.
	It is being computed during measuring step.
	@see BlElement>>onMeasure:
	measuredExtent can not be nil"
	<return: #Point>
	
	^ self layout measuredExtent