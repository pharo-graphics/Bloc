Extension { #name : #BlSpace }

{ #category : #'*Bloc-Extensions' }
BlSpace >> gtSpaceTasksFor: aView [
	<gtView>
	self taskQueue ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Tasks';
		object: [ self taskQueue ];
		view: #gtTasksFor:
]
