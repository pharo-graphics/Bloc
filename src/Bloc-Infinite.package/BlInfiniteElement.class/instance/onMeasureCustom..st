measurement
onMeasureCustom: anExtentMeasurementSpec
		
	hasFixedSize
		ifTrue: [ ^ layout measure: self with: anExtentMeasurementSpec ].
	
	"custom onMeasure"
	
	dataSourceChangedDuringMeasure ifTrue: [ 
		self eatRequestLayout.
		self processDataSourceCommandsAndSetAnimationFlags.
		
		self state willRunPredictiveAnimations
			ifTrue: [ self state isPreLayout: true ]
			ifFalse: [ 
				dataSourceManager consumeCommandsInOnePass.
				self state isPreLayout: false ].
		dataSourceChangedDuringMeasure := false.
		self resumeRequestLayout: false ].
	
	self state itemCount: dataSource itemCount.
	self eatRequestLayout.
	
	layout measure: self with: anExtentMeasurementSpec.
	self resumeRequestLayout: false.
	self state isPreLayout: false