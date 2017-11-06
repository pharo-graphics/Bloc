as yet unclassified
computeElapsedTime
	^ self children sum: [ :each | each elapsedTime ]