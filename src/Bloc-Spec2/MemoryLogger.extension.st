Extension { #name : #MemoryLogger }

{ #category : #'*Bloc-Spec2' }
MemoryLogger >> inspectorRecordingsIn: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Recordings'>
	| table refreshBlock |
	table := aBuilder newTable.

	table
		addColumn: (SpStringTableColumn
				 title: 'Timestamp'
				 evaluated: [ :each | each timestamp asString ]);
		addColumn: (SpStringTableColumn
				 title: 'Process'
				 evaluated: [ :each | each processId asString ]);
		addColumn:
			(SpStringTableColumn title: 'Type' evaluated: [ :each | each name ]);
		addColumn:
			(SpStringTableColumn title: 'Contents' evaluated: [ :each |
					 String streamContents: [ :s | each printOneLineContentsOn: s ] ]).

	table contextMenu: (SpMenuPresenter new
			 addItem: [ :item |
				 item
					 name: 'Remove all';
					 icon: (self iconNamed: #glamorousRemove);
					 action: [
						 self reset.
						 table refresh ] ];
			 yourself).

	refreshBlock := [ table items: self recordings reverse ].
	refreshBlock value.
	self announcer weak when: Announcement do: refreshBlock for: self.

	^ table
]
