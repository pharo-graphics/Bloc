as yet unclassified
assertFiredEventIs: anEventClass target: aTarget withPropagation: aBoolean
	| evt |
	evt := self firedEvents removeFirst.
	
	self assert: (evt isKindOf: anEventClass) description: 'The event should be kind of ', anEventClass asString.
	self assert: evt target = aTarget description: 'The event target should be  ', aTarget asString.
	self assert: evt canBePropagated = aBoolean description: ('The event should ', (aBoolean ifTrue:[''] ifFalse:['not']), ' be  propagated').