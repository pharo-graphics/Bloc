host space - displaying
fullscreen: aBoolean
	aBoolean ifTrue: [
		hostWindow primFullscreen
	] ifFalse: [ 
		hostWindow primUnfullscreen
	]