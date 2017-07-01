binding
bindOn: aProperty bidirectional: aBoolean

	self unbind.
	binding := BlPropertyBinding from: aProperty to: self bidirectional: aBoolean