updating
finishOn: aSplineOverScroller
	"Finish animation and finalize scroller state"

	aSplineOverScroller currentPosition: aSplineOverScroller finalPosition.
	aSplineOverScroller currentVelocity: 0.0.
	aSplineOverScroller isFinished: true.
	aSplineOverScroller updateTime: nil.