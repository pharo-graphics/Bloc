Class {
	#name : #BlParameterizedHostTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'host',
		'initialSpaces'
	],
	#classVars : [
		'TestHostsMode'
	],
	#category : #'Bloc-Tests'
}

{ #category : #accessing }
BlParameterizedHostTest class >> availableHosts [
	"Answer the collection of host instances to be tested."

	^ self testHostsMode == #allAvailable
		  ifTrue: [ BlHostRegistry default availableHosts ]
		  ifFalse: [ { BlHeadlessHost default } ]
]

{ #category : #private }
BlParameterizedHostTest class >> isAbstract [

	^ self == BlParameterizedHostTest
]

{ #category : #settings }
BlParameterizedHostTest class >> preferencesOn: aBuilder [
	<systemsettings>

	(aBuilder pickOne: #testHostsMode)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 10;
		label: 'Hosts for parameterized tests';
		domainValues: {
			'Headless host only (Fast)' -> #headlessOnly.
			'All available hosts' -> #allAvailable };
		default: #headlessOnly;
		description: 'Choose which host backends are included in BlParameterizedHostTest test suites.'
]

{ #category : #accessing }
BlParameterizedHostTest class >> testHostsMode [
	"Return the mode determining which hosts are tested in parameterized tests.
	Can be #headlessOnly or #allAvailable."

	^ TestHostsMode ifNil: [ #headlessOnly ]
]

{ #category : #accessing }
BlParameterizedHostTest class >> testHostsMode: aSymbol [

	TestHostsMode := aSymbol
]

{ #category : #'building suites' }
BlParameterizedHostTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #host
		  addOptions: self availableHosts
]

{ #category : #running }
BlParameterizedHostTest >> closeHostSpaces [

	host closeSpaces.
	host isRunning ifTrue: [ host settle ]
]

{ #category : #running }
BlParameterizedHostTest >> closeNonInitialSpaces [

	self closeSpacesExcluding: initialSpaces
]

{ #category : #running }
BlParameterizedHostTest >> closeSpacesExcluding: aCollectionOfSpaces [

	| spacesToClose |
	aCollectionOfSpaces ifNil: [ ^ self ].

	spacesToClose := host spaces copy reject: [ :each | aCollectionOfSpaces includes: each ].
	spacesToClose ifEmpty: [ ^ self ].
	spacesToClose do: [ :each | each close ].
	host isRunning ifTrue: [ host settle ]
]

{ #category : #accessing }
BlParameterizedHostTest >> host [

	^ host
]

{ #category : #accessing }
BlParameterizedHostTest >> host: aHost [

	host := aHost
]

{ #category : #'instance creation' }
BlParameterizedHostTest >> newTestingSpace [

	| aSpace |
	aSpace := BlSpace new.
	aSpace
		host: host;
		show;
		settle.

	testingSpaces add: aSpace.

	^ aSpace
]

{ #category : #running }
BlParameterizedHostTest >> setUp [

	super setUp.

	self closeHostSpaces.
	testingSpaces := OrderedCollection new.
	initialSpaces := host spaces copy
]

{ #category : #running }
BlParameterizedHostTest >> settleNonInitialSpaces [

	host isRunning ifTrue: [ host settle ].
	host spaces copy
		reject: [ :each | initialSpaces includes: each ]
		thenDo: [ :each | each settle ]
]

{ #category : #running }
BlParameterizedHostTest >> tearDown [

	testingSpaces ifNotNil: [ testingSpaces do: [ :each | each close ] ].
	self closeNonInitialSpaces.

	super tearDown
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	self
		deprecated: 'Settle the relevant space directly using #settle'
		transformWith: '`@receiver waitTestingSpaces' -> '`@receiver host spaces do: [ :each | each settle ]'.

	testingSpaces do: [ :each | each settle ]
]
