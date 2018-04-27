update
update: aDistance duration: aDuration interpolator: anInterpolator
	"Update the action with given parameters"
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].
		
	deltaX := aDistance x.
	deltaY := aDistance y.
	duration := aDuration.
	interpolator := anInterpolator.
	isChanged := true