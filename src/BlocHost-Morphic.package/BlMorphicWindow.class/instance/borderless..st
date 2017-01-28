accessing
borderless: aBoolean
	"Make window borderless if true is given"
	
	aBoolean ifTrue: [ 
		self
			makeBorderless;
			beWithoutGrips;
			removeLabelArea
	]