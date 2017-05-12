*Bloc-Extensions-Inspector
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 0>  
	^ composite list
		title: 'Items';
		display: [ :aCollection |  array ];
		beMultiple;
		withSmalltalkSearch;		
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :result | result isNil 
			ifTrue:[nil]
			ifFalse:[ (result size = 1) 
				ifTrue: [result anyOne] 
				ifFalse: [array species withAll: result]]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.