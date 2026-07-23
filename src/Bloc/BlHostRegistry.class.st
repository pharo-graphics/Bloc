"
I am a registry for available host configurations (instances).
I hold the list of available hosts and track the user's preferred host.
"
Class {
	#name : #BlHostRegistry,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#instVars : [
		'availableHosts',
		'preferredHost'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #accessing }
BlHostRegistry class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #cleanup }
BlHostRegistry class >> cleanUp [
	default := nil
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

{ #category : #accessing }
BlHostRegistry >> availableHosts [
	^ availableHosts
]

{ #category : #initialization }
BlHostRegistry >> initialize [
	| supportedClasses |
	super initialize.
	availableHosts := OrderedCollection new.
	supportedClasses := BlHost supportedHostClasses.
	supportedClasses ifEmpty: [ supportedClasses := { BlHeadlessHost } ].
	(supportedClasses select: [ :each | each isSingleton ]) do: [ :each |
		availableHosts add: each default ].
	preferredHost := availableHosts ifEmpty: [ nil ] ifNotEmpty: [ :hosts | hosts first ].
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
	(availableHosts includes: aHost) ifFalse: [
		availableHosts add: aHost ]
]

{ #category : #registration }
BlHostRegistry >> unregisterHost: aHost [
	availableHosts remove: aHost ifAbsent: [].
	preferredHost = aHost ifTrue: [
		preferredHost := availableHosts ifEmpty: [ nil ] ifNotEmpty: [ :hosts | hosts first ] ]
]
