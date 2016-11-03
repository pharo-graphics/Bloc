as yet unclassified
computeDuration
	duration := self childrenMaxValue: [ :each | each duration + each delay ] default: 0