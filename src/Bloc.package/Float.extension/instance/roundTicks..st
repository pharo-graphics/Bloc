*Bloc
roundTicks: aNumber
	"Round me to the closest tick on the scale [0...1] that has aNumber of ticks"
	<return: #Float>
	| aTickWidth aFraction |

	aNumber = 1
		ifTrue: [ ^ self rounded ].

	aTickWidth := 1.0 / aNumber.
	aFraction := (self fractionPart abs / aTickWidth) rounded * aTickWidth.
	^ self truncated + (self sign * aFraction)