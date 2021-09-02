Extension { #name : 'GLMCompositePresentation' }

{ #category : '*Bloc-Extensions' }
GLMCompositePresentation >> bloc [
	^ self custom: GLMBlocPresentation new
]

{ #category : '*Bloc-Extensions' }
GLMCompositePresentation >> blocMondrian [
	^ self custom: GLMBlocMondrianPresentation new
]

{ #category : '*Bloc-Extensions' }
GLMCompositePresentation >> blocText [
	^ self custom: GLMBlocTextPresentation new
]

{ #category : '*Bloc-Extensions' }
GLMCompositePresentation >> sparta [
	^ self custom: GLMSpartaPresentation new
]
