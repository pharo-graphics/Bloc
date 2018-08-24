Extension { #name : #BlLinearGradientPaint }

{ #category : #'*Bloc-Sparta' }
BlLinearGradientPaint >> asSpartaPaintOn: aSpartaCanvas [
	^ aSpartaCanvas paint linearGradient
		stops: self stops;
		begin: self start;
		end: self end
]
