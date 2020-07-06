Extension { #name : #BlCompositionPictureLayer }

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionPictureLayer >> gtMatrixFor: aView [
	<gtView>
	^ aView forward
		title: 'Total matrix';
		priority: 6;
		object: [ self totalMatrix ];
		view: #gtMatrixFor:
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionPictureLayer >> gtPictureFor: aView [
	<gtView>
	^ aView explicit
		title: 'Picture';
		priority: 5;
		stencil: [ self asForm asElement ]
]
