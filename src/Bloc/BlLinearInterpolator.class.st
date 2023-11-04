"
I am an interpolator where the rate of change is constant

"
Class {
	#name : 'BlLinearInterpolator',
	#superclass : 'BlInterpolator',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'interpolation' }
BlLinearInterpolator >> interpolate: aNumber [
	"f(x) = x"
	<return: #Number>

	^ aNumber
]
