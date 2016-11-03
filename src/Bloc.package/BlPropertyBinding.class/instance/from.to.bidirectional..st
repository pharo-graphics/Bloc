bind/unbind
from: aFromProperty to: aToProperty bidirectional: aBoolean
	
	from := aFromProperty.
	to := aToProperty.
	
	fromListener := BlOnChangeListener do: [:v| to value: v ].
	from addChangeListener: fromListener.
	
	aBoolean ifTrue: [
		toListener := BlOnChangeListener do: [:v| from value: v ].
		to addChangeListener: toListener.
		].