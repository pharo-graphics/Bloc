"
I provide singleton behavior and backward-compatible class-side legacy forwarders for standalone Bloc hosts.
"
Trait {
	#name : #TBlSingletonHost,
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #cleanup }
TBlSingletonHost classSide >> cleanUp [
	default := nil
]

{ #category : #accessing }
TBlSingletonHost classSide >> default [

	^ default ifNil: [
		default := self basicNew initialize; yourself ]
]

{ #category : #'api - lifecycle' }
TBlSingletonHost classSide >> isRunning [
	self
		deprecated: 'Use #default #isRunning instead'
		transformWith: '`@receiver isRunning' -> '`@receiver default isRunning'.

	^ self default isRunning
]

{ #category : #testing }
TBlSingletonHost classSide >> isSingleton [
	^ true
]

{ #category : #'driver selection' }
TBlSingletonHost classSide >> label [
	"Return a human readable title to identify myself."

	self
		deprecated: 'Use #default #label instead'
		transformWith: '`@receiver label' -> '`@receiver default label'.

	^ self default label
]

{ #category : #'instance creation' }
TBlSingletonHost classSide >> new [
	self error: 'Use #default instead'
]

{ #category : #'api - lifecycle' }
TBlSingletonHost classSide >> start [
	self
		deprecated: 'Use #default #start instead'
		transformWith: '`@receiver start' -> '`@receiver default start'.

	^ self default start
]

{ #category : #'api - lifecycle' }
TBlSingletonHost classSide >> stop [
	self
		deprecated: 'Use #default #stop instead'
		transformWith: '`@receiver stop' -> '`@receiver default stop'.

	^ self default stop
]

{ #category : #'api - ui process' }
TBlSingletonHost classSide >> uiProcessDo: aBlock [
	self
		deprecated: 'Use #default #pulseProcessDo: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver default pulseProcessDo: `@arg'.

	^ self default pulseProcessDo: aBlock
]

{ #category : #'host space - accessing' }
TBlSingletonHost classSide >> universe [
	self
		deprecated: 'Use #default #universe instead'
		transformWith: '`@receiver universe' -> '`@receiver default universe'.

	^ self default universe
]
