Extension { #name : 'Float' }

{ #category : '*Bloc' }
Float >> ceilingTicks: aNumber [
	"Round me to the tick closest to positive infinity on the scale [0...1] that has aNumber of ticks"
	<return: #Float>
	| aTickWidth aFraction |

	aNumber = 1
		ifTrue: [ ^ self floor ].

	aTickWidth := 1.0 / aNumber.
	aFraction := (self fractionPart abs / aTickWidth) ceiling * aTickWidth.
	^ self truncated + (self sign * aFraction)
]

{ #category : '*Bloc' }
Float >> floorTicks: aNumber [
	"Round me to the tick closest to negative infinity on the scale [0...1] that has aNumber of ticks"
	<return: #Float>
	| aTickWidth aFraction |

	aNumber = 1
		ifTrue: [ ^ self floor ].

	aTickWidth := 1.0 / aNumber.
	aFraction := (self fractionPart abs / aTickWidth) floor * aTickWidth.
	^ self truncated + (self sign * aFraction)
]

{ #category : '*Bloc' }
Float >> roundTicks: aNumber [
	"Round me to the closest tick on the scale [0...1] that has aNumber of ticks"
	<return: #Float>
	| aTickWidth aFraction |

	aNumber = 1
		ifTrue: [ ^ self rounded ].

	aTickWidth := 1.0 / aNumber.
	aFraction := (self fractionPart abs / aTickWidth) rounded * aTickWidth.
	^ self truncated + (self sign * aFraction)
]
