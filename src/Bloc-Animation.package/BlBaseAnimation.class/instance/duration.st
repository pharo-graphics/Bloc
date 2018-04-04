api - accessing
duration
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations.
	Note: My duration should not take my own delay into account"
	<return: #Duration>

	^ self subclassResponsibility