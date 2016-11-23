as yet unclassified
on: anEventClass sendTo: anObject
	^ self
		on: anEventClass
		do: [ :event | event sendTo: anObject ]