private - testing
shouldStartNextLoop
	<return: #Boolean>

	^ self progress >= 1.0
		and: [ self canHaveNextLoop
			and: [ self time now > self nextLoopStartTime ] ]