*Bloc-Extensions
gtInspectorMeasurementChainIn: aComposite
	<gtInspectorPresentationOrder: 90>
	| withAllParents |
	
	withAllParents := Array streamContents: [ :aStream |
		| currentElement |
		currentElement := self.
		aStream nextPut: currentElement.
		[ currentElement hasParent ] whileTrue: [ 
			currentElement := currentElement parent.
			aStream nextPut: currentElement ] ].

	aComposite fastTable 
		title: 'Measurement' translated;
		display: [ withAllParents reversed withIndexCollect: [ :anElement :anIndex |
				{
					#index -> anIndex .
					#spec -> anElement layout previousMeasurementSpec.
					#element -> anElement.
					#layout -> anElement layout
				} asDictionary ]  ];
		column: 'Index' evaluated: [ :each | (each at: #index) gtDisplayString ] width: 50;
		column: 'Width spec' evaluated: [ :each | ((each at: #spec) ifNotNil: #widthSpec) gtDisplayString ] width: 100;
		column: 'Height spec' evaluated: [ :each | ((each at: #spec) ifNotNil: #heightSpec) gtDisplayString ] width: 100;
		column: 'Layout' evaluated: [ :each | (each at: #layout) gtDisplayString ] width: 150;
		column: 'Element' evaluated: [ :each | (each at: #element) gtDisplayString ]