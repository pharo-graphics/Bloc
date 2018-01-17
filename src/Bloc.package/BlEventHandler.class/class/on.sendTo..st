instance creation
on: anEventClass sendTo: anObject
	^ self
		on: anEventClass
		do: [ :event | event sendTo: anObject ]