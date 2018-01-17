*Bloc-Extensions
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 5>
	
	^ composite bloc
		title: 'Live' translated;
		element: [ self ];
		act: [ :pres | self space root background: (Color fromHexString: '162425') ] entitled: 'Dark background';
		act: [ :pres | self space root background: (Color white) ] entitled: 'White background';
		act: [ :pres | self debug: true ] entitled: 'Debug me';
		act: [ :pres | self withAllChildrenBreadthFirst do: [ :anElement | anElement debug: true ] ] entitled: 'Debug all';
		when: [ self topMostParent == self and: [ self isAttachedToSceneGraph not ] ]