as yet unclassified
computeDuration
	duration := self children sumNumbers: [ :each | each duration + each delay ]