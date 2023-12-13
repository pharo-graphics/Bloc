Extension { #name : 'BlLinearGradientPaint' }

{ #category : '*Bloc-SVG' }
BlLinearGradientPaint >> adaptedToElement: aBlElement [
	"Sets the instance variables to match the BlElement size"
	|corner|
	corner := aBlElement geometry extent.
	self start: corner * (self start / 100) asFloatPoint.
	self end: corner * (self end / 100) asFloatPoint.
	^self
]
