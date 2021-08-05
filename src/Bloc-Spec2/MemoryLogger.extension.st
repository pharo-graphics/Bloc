Extension { #name : #MemoryLogger }

{ #category : #'*Bloc-Spec2' }
MemoryLogger >> inspectorGroupedRecordingsIn: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Grouped'>

	^ aBuilder newTable
		addColumn: (SpStringTableColumn
			title: 'Class' evaluated: [ :each | each key ]);
		addColumn: (SpStringTableColumn
			title: 'Instances' evaluated: [ :each | each value size ]);
"		send: [ :each | self select: [ :s | s class = each key ] ];"
		items: (self recordings reverse groupedBy: [ :each | each class ]) associations;
		yourself

]

{ #category : #'*Bloc-Spec2' }
MemoryLogger >> inspectorRecordingsIn: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Recordings'>

	| table refreshBlock |
	table := aBuilder newTable
		addColumn: (SpStringTableColumn
			title: 'Timestamp'
			evaluated: [ :each | each timestamp asString ]);
		addColumn: (SpStringTableColumn
			title: 'Process'
			evaluated: [ :each | each processId asString ]);
		addColumn: (SpStringTableColumn
			title: 'Type'
			evaluated: [ :each | each name ]);
		addColumn: (SpStringTableColumn
			title: 'Contents'
			evaluated: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]);
		
		contextMenu: (SpMenuPresenter new 
			addItem: [ :item |
				item
					name: 'Remove';
					icon: (self iconNamed: #glamorousRemove);
					action: [
						recordings := self recordings \ table selectedItem.
						table refresh ] ];
			addItem: [ :item |
				item
					name: 'Remove all';
					icon: (self iconNamed: #glamorousRemove);
					action: [
						self reset.
						table refresh ] ];
			yourself);
		yourself.

	refreshBlock := [ table items: self recordings reverse ].
	refreshBlock value.
	self announcer weak when: Announcement do: refreshBlock.

	^ table

"		dynamicActions: [ :t |
			{
				GLMGenericAction new
					action: [ t unregisterFromAllAnnouncements. t pane updateToolbar  ];
					icon: GLMUIThemeExtraIcons glamorousRedCircle;
					title: 'Stop' .
				GLMGenericAction new
					action: [ t pane update ];
					icon: GLMUIThemeExtraIcons glamorousGreenCircle;
					title: 'Play' }]" 
]
