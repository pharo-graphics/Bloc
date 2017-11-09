adding
computeElapsedTime
	^ self childrenMinValue: [ :each | each elapsedTime ] default: 0