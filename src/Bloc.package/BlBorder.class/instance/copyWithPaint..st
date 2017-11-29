copy
copyWithPaint: aPaint

	self
		assert: [ aPaint isNotNil ]
		description: [ 'Paint must not be nil' ].

	^ self class new
		paint: aPaint asBlPaint;
		style: style;
		width: width;
		opacity: opacity;
		yourself