Extension { #name : #BlElement }

{ #category : #'*Bloc-Spec2' }
BlElement >> asPreviewMorph [

	^ self asForm asMorph
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionPreview: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Preview'>

	^ aBuilder newMorph
		morph: self asPreviewMorph;
		yourself
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionResizers: aBuilder [
	<inspectorPresentationOrder: 4 title: 'Resizers'>

	^ aBuilder newTable
		items: self withAllParents reversed;
		addColumn: (SpStringTableColumn
			title: 'Width'
			evaluated: [ :anElement | anElement constraints horizontal resizer ]);
		addColumn: (SpStringTableColumn
			title: 'Height'
			evaluated: [ :anElement | anElement constraints vertical resizer ]);
		addColumn: (SpStringTableColumn
			title: 'Layout'
			evaluated: [ :anElement | anElement layout ]);
		addColumn: (SpStringTableColumn
			title: 'Element'
			evaluated: [ :anElement | anElement ]);
		yourself
]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Tree'>

	^ aBuilder newTree
		roots: { self };
		children: [ :each | each children ];
		expandRoots;
		yourself

]

{ #category : #'*Bloc-Spec2' }
BlElement >> inspectionUserData: aBuilder [
	<inspectorPresentationOrder: 3 title: 'User Data'>

	^ self userData inspectionItems: aBuilder 
]
