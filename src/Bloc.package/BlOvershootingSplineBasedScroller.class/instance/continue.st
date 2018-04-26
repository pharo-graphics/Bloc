private - lifecycle
continue
	"Let scrolling decide whether animation should continue even though we reached our
	destination or animation duration is over. #continue allows scroller to support
	spring back or fling animations and nicely handle overshot. If false is returned,
	animation is treated as finished.
	Returns true if animation should continue, false otherwise"
	<return: #Boolean>
	| shouldContinue |
	
	shouldContinue := self mode continueOn: self.
	shouldContinue
		"perform an update if we continue, because it is skipped during #run step"
		ifTrue: [ self update ].

	^ shouldContinue