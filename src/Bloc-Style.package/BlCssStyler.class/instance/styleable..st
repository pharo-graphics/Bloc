accessing
styleable: anObject
	anObject ifNil: [ styleable value: nil. ^ self ].
	styleable ifNil:[styleable := BlWeakRef new].
	styleable value: anObject.
	anObject styler: self