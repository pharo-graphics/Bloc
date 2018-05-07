api - scaling
minScale: aNumber
	self scaleStrategy: ((BlScalableMinDecorator on: self scaleStrategy) minScale: aNumber)