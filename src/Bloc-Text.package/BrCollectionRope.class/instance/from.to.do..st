rope - enumeration
from: aStart to: anEnd do: aBlock

	aStart
		to: anEnd
		by: (anEnd >= aStart ifTrue: [ 1 ] ifFalse: [ -1 ])
		do: [:index | aBlock value: (collection at: index) ]