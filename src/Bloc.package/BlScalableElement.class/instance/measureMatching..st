layout
measureMatching: anExtentMeasurementSpec
	| widthSpec heightSpec aTransformedBounds |
	
	aTransformedBounds := self contentElement transformation inverseTransformBounds: self measuredBounds bounds.

	widthSpec := self contentElement constraints horizontal resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds width ]
		ifFalse: [ 
			self layout
				measurementSpecFor: anExtentMeasurementSpec widthSpec
				usedSize: 0
				resizer: self contentElement constraints horizontal resizer ].
			
	heightSpec := self contentElement constraints vertical resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds height ]
		ifFalse: [
			self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0
				resizer: self contentElement constraints vertical resizer ].
			
	self contentElement measure: widthSpec @ heightSpec