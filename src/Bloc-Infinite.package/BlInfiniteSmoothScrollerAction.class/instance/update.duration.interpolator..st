update
update: aDistance duration: aDuration interpolator: anInterpolator
	"Update the action with given parameters"

	deltaX := aDistance x.
	deltaY := aDistance y.
	duration := aDuration.
	interpolator := anInterpolator.
	isChanged := true