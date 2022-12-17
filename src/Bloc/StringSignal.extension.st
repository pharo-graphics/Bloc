Extension { #name : #StringSignal }

{ #category : #'*Bloc' }
StringSignal >> asDictionary [ 

	^ super asDictionary
		at: #message put: message;
		yourself.
]

{ #category : #'*Bloc' }
StringSignal class >> fromStonDictionary: aDictionary [

	^(super fromStonDictionary: aDictionary)
		message: (aDictionary at: #message);
		yourself
]
