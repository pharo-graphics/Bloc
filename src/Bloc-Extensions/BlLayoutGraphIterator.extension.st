Extension { #name : #BlLayoutGraphIterator }

{ #category : #'*Bloc-Extensions' }
BlLayoutGraphIterator >> gtItemsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Items';
		priority: 5;
		items: [ self asArray ]
]
