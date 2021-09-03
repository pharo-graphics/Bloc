Extension { #name : 'BlElement' }

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorChildrenIn: composite [
	<gtInspectorPresentationOrder: 80>
	
	composite tree 
		title: 'Children' translated;
		rootsExpanded;
		display: [ {self} ];
		icon: [:each | | morphForm |
			morphForm := each asSpartaForm.
			(morphForm extent x > 0 and: [ morphForm extent y > 0 ])
				ifTrue: [ (morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [ Form extent: 16@16 ] ];
		children: [:each | each children ];
		when: [ self children notNil and:[ self hasChildren ] ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorEventsIn: aComposite context: aGTContext [
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
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorMeasurementChainIn: aComposite [
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
					#spec -> anElement privatePreviousMeasurementSpec.
					#element -> anElement.
					#layout -> anElement layout
				} asDictionary ]  ];
		column: 'Index' evaluated: [ :each | (each at: #index) gtDisplayString ] width: 50;
		column: 'Width spec' evaluated: [ :each | ((each at: #spec) ifNotNil: #widthSpec) gtDisplayString ] width: 100;
		column: 'Height spec' evaluated: [ :each | ((each at: #spec) ifNotNil: #heightSpec) gtDisplayString ] width: 100;
		column: 'Layout' evaluated: [ :each | (each at: #layout) gtDisplayString ] width: 150;
		column: 'Element' evaluated: [ :each | (each at: #element) gtDisplayString ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorMetricsIn: composite [
	<gtInspectorPresentationOrder: 100>  
	
	^ composite bloc
		title: 'Metrics' translated;
		element: [
			BlMetricsInspector new
				relocate: 25@25;
				for: self ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorOpenInSpace [
	<gtInspectorAction>
	^ GLMGenericAction new
		action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
		icon: GLMUIThemeExtraIcons glamorousPlay;
		title: 'Open in Space' translated;
		condition: [ self hasParent not ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 15>
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation
		title: 'Preview' translated;
		display: [ [ self asSpartaForm asMorph
				on: #mouseDown
				send: #value:
				to: [ :event | 
					morphPresentation
						selection:
							(self
								findMouseEventTargetAt: (self localPointToGlobal: event position)) ] ]
				on: Error
				do: [ :error | 
					error freeze.
					(IconicListItem
						text: error messageText
						icon:
						(self iconNamed: #smallWarningIcon))
						on: #mouseDown
							send: #value:
							to: [ :event | error defaultAction ];
						yourself ] ];
		act: [ :pres | self removeFromParent ] entitled: 'Delete'.
	^ morphPresentation
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorResizersIn: aComposite [
	<gtInspectorPresentationOrder: 90>
	| withAllParents |
	
	withAllParents := Array streamContents: [ :aStream |
		aStream nextPut: self.
		self allParentsDo: [ :anElement | aStream nextPut: anElement ] ].

	aComposite fastTable 
		title: 'Resizers' translated;
		icon: [ :each | each asSpartaForm scaledToSize: 16@16 ];
		display: [ withAllParents reversed ];
		column: 'Width' evaluated: [ :each | each constraints horizontal resizer gtDisplayString ] width: 150;
		column: 'Height' evaluated: [ :each | each constraints vertical resizer gtDisplayString ] width: 100;
		column: 'Layout' evaluated: [ :each | each layout gtDisplayString ] width: 150;
		column: 'Element' evaluated: [ :each | each gtDisplayString ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorShortcutsIn: composite [
	<gtInspectorPresentationOrder: 90>
	composite fastTable 
		title: 'Shortcuts' translated;
		display: [ self shortcuts ];
		column: 'Key' evaluated: [ :each | each combination gtDisplayString ];
		column: 'Action' evaluated: [ :each | each action asString ];
		when: [ self shortcuts notEmpty ]
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtInspectorUserDataIn: composite [
	<gtInspectorPresentationOrder: 20>  
	^ (self userData gtInspectorItemsIn: composite) 
		title: 'User data'
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtPropertiesFor: aView [
	<gtView>

	^ aView forward
		title: 'Properties';
		priority: 11;
		object: [ self properties ];
		view: #gtPropertiesFor:
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtStatesFor: aView [
	<gtView>

	^ aView forward
		title: 'States';
		priority: 10;
		object: [ self states ];
		view: #gtStatesFor:
]

{ #category : '*Bloc-Extensions' }
BlElement >> gtStylesFor: aView [
	<gtView>

	^ aView forward
		title: 'Styles';
		priority: 10;
		object: [ self styles ];
		view: #gtStylesFor:
]
