measure
measure: anElement with: anExtentSpec
	"I measure a new extent of myself and my children"
	
	self cache initializeCaches: anElement with: anExtentSpec.
	
	self
		assert: [ self cache heightMode isNotNil ]
		description: [ 'Height mode must not be nil' ].
		
	self
		assert: [ self cache widthMode isNotNil ]
		description: [ 'Width mode must not be nil' ].
	
	"first perform naive pass to measure children who already know their size"
	self naiveMeasure: anElement with: anExtentSpec.
	
	"total length does not include padding so add it here"
	self cache totalLength: self cache totalLength + (self orientation paddingLength: anElement).
	"apply minimal length restriction on total length. we should not loose
	total length, as it will be needed during improved measurement pass"
	self cache length: (self cache totalLength max: (self orientation minimalLength: anElement)).
	"length should be passed through length measurement spec to be
	more precise specified"
	self cache length: (self orientation lengthSpec sizeFor: self cache length).
	"second smarter pass to measure skipped elements during previous pass"
	(self needsImprovedMeasure: anElement)
		ifTrue: [ self improvedMeasure: anElement ]
		ifFalse: [ self cache alternativeMaxBreadth: (self cache alternativeMaxBreadth max: self cache matchingMaxBreadth) ].
	
	((self hasAnyMatchingParent: anElement) or: [ self orientation breadthMode isExact ])
		ifTrue: [ self cache maxBreadth: self cache alternativeMaxBreadth ].
	
	"max breadth does not include padding, need to add it"
	self cache maxBreadth: self cache maxBreadth + (self orientation paddingBreadth: anElement).
	"apply minimal breadth restriction"
	self cache maxBreadth: (self cache maxBreadth max: (self orientation minimalBreadth: anElement)).
	"now we finally know anElement's extent and can apply it"
	anElement measuredExtent: (self orientation
		extentBreadth: (self orientation breadthSpec sizeFor: self cache maxBreadth)
		lengthSpec: self cache length).
	
	"if there were children that match parent's breadth we should measure them now"
	self cache matchBreadth ifTrue: [
		self matchingMeasure: anElement ].
	
	"release caches used during measurement and shared between procedures"
	self cache releaseCaches