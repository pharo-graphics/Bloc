Extension { #name : #BlElementProperties }

{ #category : #'*Bloc-Extensions' }
BlElementProperties >> gtPropertiesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Properties';
		priority: 5;
		items: [ self properties asArray ]
]
