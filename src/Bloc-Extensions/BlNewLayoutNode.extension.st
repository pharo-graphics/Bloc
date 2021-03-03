Extension { #name : #BlNewLayoutNode }

{ #category : #'*Bloc-Extensions' }
BlNewLayoutNode >> gtChildrenFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Children';
		priority: 5;
		object: [ self children ];
		view: #gtChildrenFor:
]
