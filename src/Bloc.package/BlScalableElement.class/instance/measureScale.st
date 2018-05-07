layout
measureScale
	"Compute and return a scale factor of the content element based on the current scale strategy"
	| aScaleFactor |
	<return: #Number>

	self hasContentElement
		ifFalse: [ ^ 1.0 ].
	
	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self scaleStrategy scale: self contentElement within: self.
	"we must not scale by zero! Otherwise matrix becomes singular"
	aScaleFactor isZero
		ifTrue: [ aScaleFactor := 1.0 ].
		
	^ aScaleFactor