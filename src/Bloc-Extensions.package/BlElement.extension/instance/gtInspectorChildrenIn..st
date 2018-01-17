*Bloc-Extensions
gtInspectorChildrenIn: composite
	<gtInspectorPresentationOrder: 80>
	
	composite tree 
		title: 'Children' translated;
		rootsExpanded;
		display: [ {self} ];
		icon: [:each | | morphForm |
			morphForm := each asSpartaForm.
			(morphForm extent x > 0 and: [ morphForm extent y > 0 ])
				ifTrue: [ (morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [ Form extent: 16@16 ] ];
		children: [:each | each children ];
		when: [ self children notNil and:[ self hasChildren ] ]