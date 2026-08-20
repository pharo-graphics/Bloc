Class {
	#name : #BlParameterizedHostTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass',
		'initialSpaces'
	],
	#classVars : [
		'OnlyHeadlessHost'
	],
	#category : #'Bloc-Tests'
}

{ #category : #accessing }
BlParameterizedHostTest class >> hostClasses [
	"Answer the collection of host classes to be tested.
	When #onlyHeadlessHost is true, returns only BlHeadlessHost to speed up test execution."

	^ self onlyHeadlessHost
		ifTrue: [ { BlHeadlessHost } ]
		ifFalse: [ BlHost supportedHostClasses ]
]

{ #category : #private }
BlParameterizedHostTest class >> isAbstract [

	^ self == BlParameterizedHostTest
]

{ #category : #accessing }
BlParameterizedHostTest class >> onlyHeadlessHost [
	"Return true if parameterized host tests should run exclusively on BlHeadlessHost"

	^ OnlyHeadlessHost ifNil: [ false ]
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
		description: 'When enabled, BlParameterizedHostTest suites run only on BlHeadlessHost instead of all supported host classes, speeding up test runs.';
		default: [ false ]
]

{ #category : #'building suites' }
BlParameterizedHostTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #hostClass
		addOptions: self hostClasses
]

{ #category : #accessing }
BlParameterizedHostTest >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlParameterizedHostTest >> hostClass: aClass [

	hostClass := aClass
]

{ #category : #'instance creation' }
BlParameterizedHostTest >> newTestingSpace [

	| aSpace |
	aSpace := BlSpace new.
	aSpace
		host: hostClass default;
		show;
		settle.

	testingSpaces add: aSpace.

	^ aSpace
]

{ #category : #running }
BlParameterizedHostTest >> runCase [

	^ super runCase
]

{ #category : #running }
BlParameterizedHostTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
	initialSpaces := hostClass default universe spaces copy.
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

	hostClass ifNotNil: [
			hostClass default universe spaces copy reject: [ :each | initialSpaces includes: each ] thenDo: [ :each |
					[
						each close.
						each settle ]
						on: Exception
						do: [ ] ] ].

	super tearDown
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	self
		deprecated: 'Settle the relevant space directly using #settle'
		transformWith: '`@receiver waitTestingSpaces' -> '`@receiver testingSpaces do: [ :each | each settle ]'.

	testingSpaces do: [ :each | each settle ]
]
