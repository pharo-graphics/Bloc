Extension { #name : #BlSpartaRenderer }

{ #category : #'*Bloc-Extensions' }
BlSpartaRenderer class >> gtInspectorAvailableBackendsIn: composite [
	<gtInspectorPresentationOrder: 0> 
	^ composite fastList
		title: 'Backends';
		display: [ 
			"The FastTable renderer needs to access elements by index so we transform
			the collection to an OrderedCollection. Subclasses can override the #display
			block to provide a different behaviour. The previous renderer had this behaviour
			implemented in the renderer."
			self availableCanvasBuilderClasses asOrderedCollection ];
		beMultiple;	
		format: [ :each | each label, (each = defaultCanvasBuilder class
				ifTrue: [ ' (current)' ]
				ifFalse: ['']) ]
]
