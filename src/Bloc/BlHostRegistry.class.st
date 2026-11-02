"
I am a registry for available host configurations (instances).
I hold the list of available hosts and track the user's preferred host.
"
Class {
	#name : #BlHostRegistry,
	#superclass : #Object,
	#instVars : [
		'availableHosts',
		'preferredHost'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #cleanup }
BlHostRegistry class >> cleanUp [

	default := nil
]

{ #category : #accessing }
BlHostRegistry class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #'class initialization' }
BlHostRegistry class >> initialize [

	SessionManager default
		registerGuiClassNamed: self name
		atPriority: 200
]

{ #category : #settings }
BlHostRegistry class >> settingsOn: aBuilder [
	<systemsettings>

	(aBuilder pickOne: #preferredHost)
		parent: Bloc groupSymbolForBloc;
		target: self default;
		order: 1;
		label: 'Preferable host';
		domainValues: (self default availableHosts
			collect: [ :aHost | aHost label -> aHost ]);
		description: 'Choose the option that spaces will use to open, unless they have a particular host.'.
]

{ #category : #'system startup' }
BlHostRegistry class >> shutDown: isQuitting [

	default ifNotNil: [ :registry |
		registry availableHosts do: [ :eachHost |
			eachHost shutDown: isQuitting ] ]
]

{ #category : #'system startup' }
BlHostRegistry class >> startUp: isResuming [

	default ifNotNil: [ :registry |
		registry refreshAvailableHosts.
		registry availableHosts do: [ :eachHost |
			eachHost startUp: isResuming ] ]
]

{ #category : #accessing }
BlHostRegistry >> availableHostClasses [

	^ (self availableHosts collect: [ :each | each class ]) asArray
]

{ #category : #accessing }
BlHostRegistry >> availableHosts [

	^ availableHosts
]

{ #category : #'api - lifecycle' }
BlHostRegistry >> closeSpaces [

	self availableHosts do: [ :eachHost | eachHost closeSpaces ]
]

{ #category : #accessing }
BlHostRegistry >> defaultHost [
	"Answer the available host with lowest order, or nil if no host is available."

	^ availableHosts
		ifNotEmpty: [ availableHosts first ]
		ifEmpty: [ nil ]
]

{ #category : #initialization }
BlHostRegistry >> initialize [

	super initialize.
	availableHosts := OrderedCollection new.
	self refreshAvailableHosts
]

{ #category : #accessing }
BlHostRegistry >> preferredHost [
	"Answer the explicitly preferred host if valid, or fallback to the default host."

	(availableHosts includes: preferredHost) ifFalse: [
		preferredHost := nil ].
	^ preferredHost ifNil: [ self defaultHost ]
]

{ #category : #accessing }
BlHostRegistry >> preferredHost: aHost [

	preferredHost := aHost
]

{ #category : #initialization }
BlHostRegistry >> refreshAvailableHosts [
	"Recompute available hosts for the current session and environment."

	"First: Prune hosts that are no longer supported in the current session"
	availableHosts
		select: [ :eachHost | eachHost isSupported not ]
		thenDo: [ :eachHost | eachHost stop ].
	availableHosts removeAllSuchThat: [ :eachHost | eachHost isSupported not ].

	"Second: Ensure all supported singleton hosts are registered"
	TBlSingletonHost users do: [ :eachClass |
		eachClass isSupported ifTrue: [
			self registerHost: eachClass default ] ].

	"Third: Ensure preferredHost is valid and present"
	(availableHosts includes: preferredHost) ifFalse: [
		preferredHost := nil ]
]

{ #category : #registration }
BlHostRegistry >> registerHost: aHost [

	aHost isSupported ifFalse: [ ^ self ].
	(availableHosts includes: aHost) ifTrue: [ ^ self ].
	availableHosts add: aHost.
	availableHosts sort: [ :a :b | a order < b order ]
]

{ #category : #registration }
BlHostRegistry >> unregisterHost: aHost [

	availableHosts remove: aHost ifAbsent: [].

	preferredHost = aHost ifTrue: [
		preferredHost := nil ]
]
