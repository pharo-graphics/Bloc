*Bloc-Extensions
gtInspectorResizersIn: aComposite
	<gtInspectorPresentationOrder: 90>
	| withAllParents |
	
	withAllParents := Array streamContents: [ :aStream |
		aStream nextPut: self.
		self parentsDo: [ :anElement | aStream nextPut: anElement ] ].

	aComposite fastTable 
		title: 'Resizers' translated;
		icon: [ :each | each asSpartaForm scaledToSize: 16@16 ];
		display: [ withAllParents reversed ];
		column: 'Width' evaluated: [ :each | each constraints horizontal resizer gtDisplayString ] width: 150;
		column: 'Height' evaluated: [ :each | each constraints vertical resizer gtDisplayString ] width: 100;
		column: 'Layout' evaluated: [ :each | each layout gtDisplayString ] width: 150;
		column: 'Element' evaluated: [ :each | each gtDisplayString ]