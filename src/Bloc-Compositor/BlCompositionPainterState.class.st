Class {
	#name : #BlCompositionPainterState,
	#superclass : #Object,
	#instVars : [
		'commands'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #hook }
BlCompositionPainterState >> applyOn: aCanvas [
	commands reverseDo: [ :eachCommand | eachCommand pushOn: aCanvas ]
]

{ #category : #hook }
BlCompositionPainterState >> applyOnLayer: aSkiaLayer [
	commands reverseDo: [ :eachCommand | eachCommand pushOnLayer: aSkiaLayer ]
]

{ #category : #'gt-extension' }
BlCompositionPainterState >> gtCommandsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Commands';
		priority: 3;
		items: [ commands asArray reversed ];
		column: 'Type' item: [ :eachCommand | eachCommand type ] width: 100;
		column: 'By' do: [ :aColumn |
			aColumn
				matchParent;
				itemStencil: [ :eachCommand |
					BrEditor new
						hMatchParent;
						vFitContent;
						look: (BrGlamorousRegularEditorLook new glamorousCodeTinySize);
						text: eachCommand commandString ] ];
		column: 'Offset' item: [ :eachCommand | eachCommand offset ] width: 100
]

{ #category : #initialization }
BlCompositionPainterState >> initialize [
	super initialize.
	
	commands := Stack new
]

{ #category : #testing }
BlCompositionPainterState >> isEmpty [
	^ commands isEmpty
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pop [
	commands pop
]

{ #category : #copying }
BlCompositionPainterState >> postCopy [
	commands := commands copy
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushClip: aPath offset: anOffset [
	commands push: (BlCompositionPainterStateClip new clip: aPath; offset: anOffset)
]

{ #category : #'api - commands' }
BlCompositionPainterState >> pushTransform: aMatrix offset: anOffset [
	commands push: (BlCompositionPainterStateTransformation new matrix: aMatrix; offset: anOffset)
]
