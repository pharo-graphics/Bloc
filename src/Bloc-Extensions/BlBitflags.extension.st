Extension { #name : #BlBitflags }

{ #category : #'*Bloc-Extensions' }
BlBitflags >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Flags';
		items: [ self asDictionary associations sorted: [ :a :b | a key < b key ] ];
		column: 'Key' text: [ :each | each key gtDisplayText ];
		column: 'Value' text: [ :each | each value gtDisplayText ]
]
