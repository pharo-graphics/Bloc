Extension { #name : #BlLayoutNodeChildren }

{ #category : #'*Bloc-Extensions' }
BlLayoutNodeChildren >> gtChildrenFor: aView [
	<gtView>
	
	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ self ];
		children: #children
]
