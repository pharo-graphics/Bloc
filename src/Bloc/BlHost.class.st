"
I am the abstract class for a Host.
I define an environment that can be used to provide actual screen spaces and rendering.
A Host can be compared to a driver that communicates with the native multimedia API.

"
Class {
	#name : #BlHost,
	#superclass : #Object,
	#classVars : [
		'PreferableHostClass'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #testing }
BlHost class >> hasUniverse [

	^ BlParallelUniverse existsForHost: self
]

{ #category : #'api - lifecycle' }
BlHost class >> isRunning [
	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> isSupported [

	^ false
]

{ #category : #'driver selection' }
BlHost class >> label [
	"Return a human readable title to identify myself."

	^ self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> pickHost [
	"Answer a new instance of the preferable host."
	
	^ self preferableHostClass new
]

{ #category : #settings }
BlHost class >> preferableHostClass [

	^ PreferableHostClass ifNil: [
		PreferableHostClass := self prioritaryHostClass ]
]

{ #category : #settings }
BlHost class >> preferableHostClass: aHostClass [
	
	PreferableHostClass := aHostClass

]

{ #category : #'driver selection' }
BlHost class >> prioritaryHostClass [
	"Answer either the supported host with the lowest priority, or
	`BlHeadlessHost` if there isn't any supported host."

	^ self supportedHostClasses
		ifEmpty: [ BlHeadlessHost ]
		ifNotEmpty: [ :theHostClasses | theHostClasses first ]
]

{ #category : #'driver selection' }
BlHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	A lower value is more likely to become the default host."
	
	^ self subclassResponsibility
]

{ #category : #settings }
BlHost class >> settingsOn: aBuilder [
	<systemsettings>

	(aBuilder pickOne: #preferableHostClass)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 1;
		label: 'Preferable host';
		domainValues: (self supportedHostClasses
			collect: [ :aHostClass | aHostClass label -> aHostClass ]);
		description: 'Choose the option that spaces will use to open, unless they have a particular host.'.

]

{ #category : #'api - lifecycle' }
BlHost class >> start [

	self subclassResponsibility
]

{ #category : #'api - lifecycle' }
BlHost class >> stop [

	self subclassResponsibility
]

{ #category : #'driver selection' }
BlHost class >> supportedHostClasses [
	"Return all supported Bloc host classes, sorted by priority (lowest first)."

	^ (self allSubclasses
			select: [ :aHostClass | aHostClass isSupported ])
			sort: [ :a :b | a priority < b priority ]
]

{ #category : #'api - ui process' }
BlHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
]

{ #category : #'host space - accessing' }
BlHost class >> universe [

	^ BlParallelUniverse forHost: self
]

{ #category : #'api - lifecycle' }
BlHost >> isRunning [
	"Return true if host is initialized and running"

	^ self class isRunning
]

{ #category : #'host space - accessing' }
BlHost >> newHostRenderer [

	^ BlHostRenderer preferableClass new
]

{ #category : #'host - api' }
BlHost >> newHostSpaceFor: aSpace [
	"Answer a new host space"

	^ self subclassResponsibility
]

{ #category : #'paragraph - measuring' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 
	"Update the received paragraph with its measurement."

	BlHostRenderer preferableClass offscreenMeasureTextParagraph: aBlTextParagraph
]

{ #category : #'host - testing' }
BlHost >> runOneCycle [
	
	"The host can do something while waiting for the pulse to happen. Useful for Morphic when the test run in the UI thread"
]

{ #category : #'api - lifecycle' }
BlHost >> start [

	self class start
]

{ #category : #'api - lifecycle' }
BlHost >> stop [

	self class stop
]

{ #category : #enumerating }
BlHost >> uiProcessDo: aBlock [

	self class uiProcessDo: aBlock
]

{ #category : #'host space - accessing' }
BlHost >> universe [
	
	^ self class universe
]
