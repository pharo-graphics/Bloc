private - testing
shouldStop
	<return: #Boolean>

	^ self progress >= 1.0
		and: [ self canHaveNextLoop not ]