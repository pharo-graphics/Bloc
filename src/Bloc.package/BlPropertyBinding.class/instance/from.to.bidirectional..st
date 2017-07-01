bind/unbind
from: aFromProperty to: aToProperty bidirectional: isBidirectional
	
	from := aFromProperty.
	to := aToProperty.
	
	fromListener := BlOnChangeListener do: [ :v | to value: v ].
	from addChangeListener: fromListener.

	isBidirectional
		ifFalse: [ ^ self ].

	toListener := BlOnChangeListener do: [ :v | from value: v ].
	to addChangeListener: toListener