Class {
	#name : #BlParameterizedHostTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'host',
		'initialSpaces'
	],
	#classVars : [
		'OnlyHeadlessHost'
	],
	#category : #'Bloc-Tests'
}

{ #category : #accessing }
BlParameterizedHostTest class >> availableHosts [
	"Answer the collection of host instances to be tested.
	When #onlyHeadlessHost is true, returns only BlHeadlessHost default to speed up test execution."

	^ self onlyHeadlessHost
		  ifTrue: [ { BlHeadlessHost default } ]
		  ifFalse: [ BlHostRegistry default availableHosts ]
]

{ #category : #private }
BlParameterizedHostTest class >> isAbstract [

	^ self == BlParameterizedHostTest
]

{ #category : #accessing }
BlParameterizedHostTest class >> onlyHeadlessHost [
	"Return true if parameterized host tests should run exclusively on BlHeadlessHost"

	^ OnlyHeadlessHost ifNil: [ true ]
]

{ #category : #accessing }
BlParameterizedHostTest class >> onlyHeadlessHost: aBoolean [

	OnlyHeadlessHost := aBoolean
]

{ #category : #settings }
BlParameterizedHostTest class >> preferencesOn: aBuilder [
	<systemsettings>

	(aBuilder setting: #onlyHeadlessHost)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 10;
		label: 'Test on headless host only';
		description: 'When enabled, BlParameterizedHostTest suites run only on BlHeadlessHost default instead of all supported host instances, speeding up test runs.';
		default: [ true ]
]

{ #category : #'building suites' }
BlParameterizedHostTest class >> testParameters [

	^ ParametrizedTestMatrix new
		  forSelector: #host
		  addOptions: self availableHosts
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

	testingSpaces := OrderedCollection new.
	initialSpaces := host universe spaces copy.
]

{ #category : #running }
BlParameterizedHostTest >> tearDown [

	testingSpaces do: [ :each |
			[
				each
					close;
					settle ]
				on: Exception
				do: [ ] ].

	host ifNotNil: [
			host universe spaces copy reject: [ :each | initialSpaces includes: each ] thenDo: [ :each |
					[
						each close.
						each settle ]
						on: Exception
						do: [ ] ] ].

	super tearDown
]

{ #category : #accessing }
BlParameterizedHostTest >> testingSpaces [

	^ testingSpaces
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	self
		deprecated: 'Settle the relevant space directly using #settle'
		transformWith: '`@receiver waitTestingSpaces' -> '`@receiver testingSpaces do: [ :each | each settle ]'.

	testingSpaces do: [ :each | each settle ]
]
