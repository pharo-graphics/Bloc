Extension { #name : #BlMouseWheelEvent }

{ #category : #'*Bloc-Extensions' }
BlMouseWheelEvent >> gtVectorFor: aView [
	<gtView>
	self vector ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Vector';
		object: [ self vector ];
		view: #gtDegreeFor:
]
