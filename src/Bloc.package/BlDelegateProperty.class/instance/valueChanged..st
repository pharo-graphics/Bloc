accessing
valueChanged: anObject
	anObject ifNil:[^ self].
	delegationBlock value: anObject value: self rawValue