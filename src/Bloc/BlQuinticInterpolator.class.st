"
I represent a special case of a quintic function.
https://en.wikipedia.org/wiki/Quintic_function

My interpolation function is
   f(x) = x^5 - 5x^4 + 10x^3 - 10x^2 + 5x

It can be simplified to
   f(x) = (x - 1)^5 + 1

"
Class {
	#name : #BlQuinticInterpolator,
	#superclass : #BlInterpolator,
	#category : #'Bloc-Basic-Interpolators'
}

{ #category : #interpolation }
BlQuinticInterpolator >> interpolate: aNumber [
	"f(x)
		= x^5 - 5x^4 + 10x^3 - 10x^2 + 5x
		= (x - 1)^5 + 1"
	<return: #Number>
	| t |

	t := aNumber - 1.0.
	^ (t * t * t * t * t) + 1.0
]
