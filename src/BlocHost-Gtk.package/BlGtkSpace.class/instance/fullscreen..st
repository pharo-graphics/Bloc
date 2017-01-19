accessing
fullscreen: aBoolean
	aBoolean ifTrue: [
		hostWindow primFullscreen
	] ifFalse: [ 
		hostWindow primUnfullscreen
	]