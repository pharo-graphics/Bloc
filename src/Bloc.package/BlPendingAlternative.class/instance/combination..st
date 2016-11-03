accessing
combination: anObject
	combination := anObject.
	pendingAlternatives := combination alternative collect: [ :each | each asPending ]