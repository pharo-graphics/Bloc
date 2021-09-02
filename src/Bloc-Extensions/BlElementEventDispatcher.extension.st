Extension { #name : #BlElementEventDispatcher }

{ #category : #'*Bloc-Extensions' }
BlElementEventDispatcher >> gtEventsFor: aView [
	<gtView>
	^ aView columnedList
		priority: 2;
		title: 'Events';
		items: [ (activatedElementEvents asDictionary associations
				sorted: [ :a :b | a key < b key ])
				, ((activatedGeneralEvents ifNil: [ #() ]) asArray collect: [ :each | each -> true ]) ];
		column: 'Type' text: [ :each | each key ];
		column: 'Enabled' text: [ :each | each value ]
]
