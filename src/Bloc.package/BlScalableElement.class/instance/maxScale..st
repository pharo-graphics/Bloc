scale
maxScale: aNumber
	self scaleStrategy: ((BlScalableMaxDecorator on: self scaleStrategy) maxScale: aNumber)