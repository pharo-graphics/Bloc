*Bloc-Extensions
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 5>
	
	^ composite bloc
		title: 'Live' translated;
		element: [ self ];
		act: [ :pres | self debug: true. pres updateToolbar ]
			icon: (Smalltalk ui icons iconNamed: #glamorousBug)
			entitled: 'Debug me';
		act: [ :pres | self debug: true. self allChildrenBreadthFirstDo: [ :anElement | anElement debug: true ] ] entitled: 'Debug all';
		when: [ self topMostParent == self ]