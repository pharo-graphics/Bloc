as yet unclassified
computeDuration
	duration := self children max: [ :each | each duration + each delay ]