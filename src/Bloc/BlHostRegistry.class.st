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

{ #category : #'class initialization' }
BlHostRegistry class >> shutDown: isQuitting [

	default ifNotNil: [ :registry |
		registry availableHosts do: [ :eachHost |
			eachHost hasUniverse ifTrue: [ eachHost universe stop ] ] ]
]

{ #category : #'class initialization' }
BlHostRegistry class >> startUp: isResuming [

	default ifNotNil: [ :registry |
		registry refreshAvailableHosts.
		registry availableHosts do: [ :eachHost |
			eachHost hasUniverse ifTrue: [ eachHost universe start ] ] ]
]

{ #category : #accessing }
BlHostRegistry >> availableHostClasses [

	^ (self availableHosts collect: [ :each | each class ]) asArray
]

{ #category : #accessing }
BlHostRegistry >> availableHosts [

	^ availableHosts
]

{ #category : #initialization }
BlHostRegistry >> initialize [

	super initialize.
	availableHosts := OrderedCollection new.
	self refreshAvailableHosts
]

{ #category : #accessing }
BlHostRegistry >> preferredHost [

	^ preferredHost
]

{ #category : #accessing }
BlHostRegistry >> preferredHost: aHost [

	preferredHost := aHost
]

{ #category : #'api - lifecycle' }
BlHostRegistry >> closeAllSpaces [

	self availableHosts do: [ :eachHost |
		eachHost hasUniverse ifTrue: [
			eachHost universe closeSpaces.
			eachHost stop ] ]
]

{ #category : #initialization }
BlHostRegistry >> refreshAvailableHosts [
	"Recompute available hosts for the current session and environment."

	"1. Prune hosts that are no longer supported in the current session/environment"
	availableHosts
		select: [ :eachHost | eachHost isSupported not ]
		thenDo: [ :eachHost |
			eachHost hasUniverse ifTrue: [ eachHost universe stop ] ].
	availableHosts removeAllSuchThat: [ :eachHost | eachHost isSupported not ].

	"2. Ensure all supported singleton hosts are registered"
	TBlSingletonHost users do: [ :eachClass |
		eachClass isSupported ifTrue: [
			self registerHost: eachClass default ] ].

	"3. Ensure preferredHost is valid and present"
	(availableHosts includes: preferredHost) ifFalse: [
		preferredHost :=
			availableHosts
				ifNotEmpty: [ availableHosts first ]
				ifEmpty: [ nil ] ]
]

{ #category : #registration }
BlHostRegistry >> registerHost: aHost [

	(availableHosts includes: aHost) ifFalse: [
		availableHosts add: aHost.
		self sortAvailableHosts.
		preferredHost ifNil: [ preferredHost := availableHosts first ] ]
]

{ #category : #private }
BlHostRegistry >> sortAvailableHosts [

	availableHosts sort: [ :a :b | a priority < b priority ]
]

{ #category : #registration }
BlHostRegistry >> unregisterHost: aHost [

	availableHosts remove: aHost ifAbsent: [].

	preferredHost = aHost ifTrue: [
		preferredHost :=
			availableHosts
				ifEmpty: [ nil ]
				ifNotEmpty: [ :hosts | hosts first ] ]
]
