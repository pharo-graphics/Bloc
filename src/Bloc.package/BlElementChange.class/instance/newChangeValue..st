instance creation
newChangeValue: anObject

	^ Bloc debugModeEnabled
		ifTrue: [ BlElementChangeRecordWithContext new changedValue: anObject; context: thisContext copyStack ]
		ifFalse: [ BlElementChangeRecord new changedValue: anObject ]