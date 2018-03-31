private - scheduling
enableRunOnAnimationRequests

	eatRunOnAnimationRequest := false.
	reSchedulePostAnimationCallback
		ifTrue: [ self postOnAnimation ]