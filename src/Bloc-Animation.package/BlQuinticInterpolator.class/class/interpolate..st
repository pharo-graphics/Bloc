interpolation
interpolate: aNumber
	"f(x)
		= x^5 - 5x^4 + 10x^3 - 10x^2 + 5x
		= (x - 1)^5 + 1"
	<return: #Number>
	| t |

	t := aNumber - 1.0.
	^ (t * t * t * t * t) + 1.0