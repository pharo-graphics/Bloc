public
propagatingSelectionOnClick
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