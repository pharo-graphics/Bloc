api - accessing
duration
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"
	<return: #Duration>

	^ self animations
		ifEmpty: [ 0 seconds ]
		ifNotEmpty: [ :theAnimations | theAnimations sum: [ :anAnimation | (anAnimation duration + anAnimation delay) * anAnimation loops ] ]