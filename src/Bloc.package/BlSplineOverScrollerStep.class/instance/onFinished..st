hooks
onFinished: aSplineOverScroller
	"Is sent after animation duration is reached. It does not necessarily mean that scrolling should stop,
	for example if we overshoot the target we should to bounce back.
	Return true if animation should continue, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility