Extension { #name : #BlRope }

{ #category : #'*Bloc-Spec2' }
BlRope >> inspectionForStructure: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Tree structure'>

	^ aBuilder newTreeTable
		roots: { self };
		children: [ :each | each children ];
		addColumn: (SpStringTableColumn 
			title: 'String'
			evaluated: [ :each | each asString trimBoth truncateWithElipsisTo: 50 ]);
		addColumn: (SpStringTableColumn 
			title: 'Attributes'
			evaluated: [ :each | each iterator attributes asCommaString ]);
		addColumn: ((SpStringTableColumn 
			title: 'Size'
			evaluated: [ :each | each size ])
			width: 40;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Depth'
			evaluated: [ :each | each depth ])
			width: 40;
			yourself);
		addColumn: (SpStringTableColumn 
			title: 'Class'
			evaluated: [ :each | each className ])
			beNotExpandable;
		expandAll;
		yourself

"		display: [ { self } ];
		column: 'Class' evaluated: [ :each | each class name ];
		column: 'Description' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each ]"
]
