*Bloc-Extensions
gtInspectorEventsIn: aComposite context: aGTContext
	<gtInspectorPresentationOrder: 40>
	| recordedAnnouncements anEventFilter |
	
	recordedAnnouncements := CollectionValueHolder value: OrderedCollection new.
	
	anEventFilter := BlEventHandler
		on: BlEvent
		do: [ :anEvent | UIManager default defer: [ recordedAnnouncements addAnnouncementFirst: anEvent ] ].
	self addEventFilter: anEventFilter.
	
	aGTContext when: GLMBrowserClosing do: [ self removeEventFilter: anEventFilter ].

	aComposite fastTable
		title: 'Events';
		display: [ recordedAnnouncements value ];
		column: 'Time' evaluated: #key;
		column: 'Event' evaluated: #value;
		send: #value;
		showOnly: 50;
		format: #gtDisplayString;
		updateOn: Announcement from: recordedAnnouncements gtAnnouncer;
		act: [ :table | 
			recordedAnnouncements removeAll.
			table update ] 
			icon: GLMUIThemeExtraIcons glamorousCancel 
			entitled: 'Reset'