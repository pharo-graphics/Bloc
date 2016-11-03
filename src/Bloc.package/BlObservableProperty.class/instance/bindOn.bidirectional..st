binding
bindOn: aProperty bidirectional: aBoolean
	binding ifNotNil: [ self unbind ].
	binding := BlPropertyBinding from: aProperty to: self bidirectional: aBoolean