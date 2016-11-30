layout
dispatchLayout
	
	self state isMeasuring: false.
	self state isStartStep
		ifTrue: [
			self dispatchLayoutFirstStep.
			self layout exactMeasurementSpecFrom: self.
			self dispatchLayoutSecondStep ]
		ifFalse: [ 
			(dataSourceController hasCommands or: [
				layout width ~= self width or: [ 
					layout height ~= self height ] ])
				ifTrue: [
					self layout exactMeasurementSpecFrom: self.
					self dispatchLayoutSecondStep ]
				ifFalse: [ self layout exactMeasurementSpecFrom: self ] ].
	self dispatchLayoutThirdStep