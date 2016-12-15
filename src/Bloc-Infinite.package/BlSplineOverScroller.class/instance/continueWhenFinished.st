scrolling
continueWhenFinished
	| aResult |
	state = Spline
		ifTrue: [ aResult := self continueWhenFinishedSpline ].
	state = Ballistic
		ifTrue: [ aResult := self continueWhenFinishedBallistic ].
	state = Cubic
		ifTrue: [ aResult := self continueWhenFinishedCubic ].
		
	aResult
		ifFalse: [ ^ false ].
	
	self update.
	^ true