*Bloc-Extension-Inspector
gtInspectorSubelementsIn: composite
	<gtInspectorPresentationOrder: 80>  
	composite tree 
		title: 'Children';
		rootsExpanded;
		display: [:each | {each} ];
		icon: [:each | | morphForm |
			morphForm := each asForm.
			(morphForm extent x > 0 and: [morphForm extent y > 0 ])
				ifTrue: [(morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [Form extent: 16@16] ];
		children: [:each | each children ];
		when: [:each | each children notNil and:[ each hasChildren ] ]