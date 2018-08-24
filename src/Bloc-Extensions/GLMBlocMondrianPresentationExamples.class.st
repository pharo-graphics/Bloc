Class {
	#name : #GLMBlocMondrianPresentationExamples,
	#superclass : #Object,
	#category : 'Bloc-Extensions-Examples'
}

{ #category : #public }
GLMBlocMondrianPresentationExamples >> propagatingSelectionOnClick [
	<gtExample>
	| composite |
	composite := GLMCompositePresentation new.
	composite blocMondrian 
		painting: [ :view |
			view nodes 
				shape: [ :each | 
					BlElement new 
						background: (Color blue);
						when: BlClickEvent do: [ :click |
							view topStep root fireEvent: (GLMBlocObjectToSelect new toSelect: each) ] ];
				with: (1 to: 5).
			view layout tree ].
	^ composite startOn: 42
]

{ #category : #public }
GLMBlocMondrianPresentationExamples >> simple [
	<gtExample>
	| composite |
	composite := GLMCompositePresentation new.
	composite blocMondrian
		painting: [ :view :col | view nodes with: col ].
	^ composite startOn: (1 to: 100)
]
