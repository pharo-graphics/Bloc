instance creation
on: anEventClass do: aBlock
	^ self new
		eventClass: anEventClass;
		action: aBlock;
		yourself