adding
computedElapsedTime
	^ self childrenMinValue: [ :each | each elapsedTime ] default: 0