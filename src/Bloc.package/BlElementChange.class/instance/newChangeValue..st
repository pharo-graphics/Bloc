instance creation
newChangeValue: anObject

	^ Bloc debugModeEnabled
		ifTrue: [ BlElementChangeValueWithContext new changedValue: anObject; context: thisContext copyStack ]
		ifFalse: [ BlElementChangeValue new changedValue: anObject ]