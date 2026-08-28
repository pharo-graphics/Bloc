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

	SessionManager default registerGuiClassNamed: self name
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

	isResuming ifFalse: [ ^ self ].
	default ifNotNil: [ :registry |
		registry refreshAvailableHosts.
		registry availableHosts do: [ :eachHost |
			eachHost hasUniverse ifTrue: [ eachHost universe start ] ] ]
]

{ #category : #accessing }
BlHostRegistry >> availableHosts [

	^ availableHosts
]

{ #category : #initialization }
BlHostRegistry >> initialize [

	super initialize.
	self refreshAvailableHosts
]

{ #category : #initialization }
BlHostRegistry >> refreshAvailableHosts [
	"Recompute available hosts for the current session and environment."

	availableHosts :=
		(BlHost supportedHostClasses ifEmpty: [ { BlHeadlessHost } ])
			select: [ :each | each isSingleton ]
			thenCollect: [ :each | each default ].

	(availableHosts includes: preferredHost) ifFalse: [
		preferredHost :=
			availableHosts
				ifEmpty: [ nil ]
				ifNotEmpty: [ :hosts | hosts first ] ]
]

{ #category : #accessing }
BlHostRegistry >> preferredHost [

	^ preferredHost
]

{ #category : #accessing }
BlHostRegistry >> preferredHost: aHost [

	preferredHost := aHost
]

{ #category : #registration }
BlHostRegistry >> registerHost: aHost [

	(availableHosts includes: aHost)
		ifFalse: [ availableHosts add: aHost ]
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
