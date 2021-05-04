Extension { #name : #BlCompositionPainterState }

{ #category : #'*Bloc-Extensions' }
BlCompositionPainterState >> gtCommandsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Commands';
		priority: 3;
		items: [ commands asArray reversed ];
		column: 'Type' item: [ :eachCommand | eachCommand type ] width: 100;
		column: 'By' do: [ :aColumn |
			aColumn
				stencil: [ :eachCommand |
					BrEditor new
						hMatchParent;
						vFitContent;
						look: (BrGlamorousRegularEditorAptitude new glamorousCodeTinySize);
						text: eachCommand commandString ] ];
		column: 'Offset' item: [ :eachCommand | eachCommand offset ] width: 100
]
