accessing
opacity
	<return: #Number>

	^ opacity ifNil: [ self defaultOpacity ]