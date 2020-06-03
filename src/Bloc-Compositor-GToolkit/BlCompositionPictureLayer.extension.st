Extension { #name : #BlCompositionPictureLayer }

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionPictureLayer >> gtPictureFor: aView [
	<gtView>
	^ aView explicit
		title: 'Picture';
		priority: 5;
		stencil: [ self asForm asElement ]
]
