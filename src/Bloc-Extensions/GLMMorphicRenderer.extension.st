Extension { #name : 'GLMMorphicRenderer' }

{ #category : '*Bloc-Extensions' }
GLMMorphicRenderer >> renderBlocMondrianPresentation: aBlocMondrianPresentation [ 
	^ GLMMorphicBlocMondrianRenderer render: aBlocMondrianPresentation from: self
]

{ #category : '*Bloc-Extensions' }
GLMMorphicRenderer >> renderBlocPresentation: aBlocPresentation [ 
	^ GLMMorphicBlocRenderer render: aBlocPresentation from: self
]

{ #category : '*Bloc-Extensions' }
GLMMorphicRenderer >> renderBlocTextPresentation: aPresentation [
	^ GLMMorphicBlocTextRenderer render: aPresentation from: self
]

{ #category : '*Bloc-Extensions' }
GLMMorphicRenderer >> renderSpartaPresentation: aSpartaPresentation [ 
	^ GLMMorphicSpartaRenderer render: aSpartaPresentation from: self
]
