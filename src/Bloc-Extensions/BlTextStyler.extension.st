Extension { #name : #BlTextStyler }

{ #category : #'*Bloc-Extensions' }
BlTextStyler >> gtStylesFor: aView [
	<gtView>
	
	self stylers
		ifEmpty: [ ^ aView empty ].
	
	^ aView tree
		title: 'Styles';
		priority: 5;
		items: [ { self } ];
		children: #stylers;
		expandAll
]
