copying
copyFrom: anotherObject
	super copyFrom: anotherObject.
	
	traversedTargets := LinkedList new