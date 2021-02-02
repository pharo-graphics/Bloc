Extension { #name : #BlVector2D }

{ #category : #'*Bloc-Extensions' }
BlVector2D >> gtDegreeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Degree';
		priority: 1;
		stencil: [ BlVector2DDescriptionElement new vector: self ]
]
