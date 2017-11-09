adding
computeDuration
	duration := self children sum: [ :each | each duration + each delay ]