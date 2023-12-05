Class {
	#name : 'BlElementDisjunctionState',
	#superclass : 'BlElementCompositeState',
	#category : 'Bloc-Basic-State',
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'testing' }
BlElementDisjunctionState >> matches: aSetOfStates [
	^ (self left matches: aSetOfStates) or: [ self right matches: aSetOfStates ]
]

{ #category : 'printing' }
BlElementDisjunctionState >> printOn: aStream [
	aStream
		nextPut: $(;
		print: self left;
		nextPutAll: ' | ';
		print: self right;
		nextPut: $)
]
