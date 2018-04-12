enumerating
do: aBlock
	self from ifNil: [ ^ self ].
	self isNotEmpty ifTrue: [ aBlock value: self ]