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
	default ifNotNil: [
		BlHostRegistry default unregisterHost: default.
		default := nil ]
]

{ #category : #accessing }
TBlSingletonHost classSide >> default [

	^ default ifNil: [
		default := self basicNew initialize; yourself.
		BlHostRegistry default registerHost: default.
		default ]
]

{ #category : #'api - lifecycle' }
TBlSingletonHost classSide >> isRunning [
	self
		deprecated: 'Use #default #isRunning instead'
		transformWith: '`@receiver isRunning' -> '`@receiver default isRunning'.

	^ self default isRunning
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

{ #category : #'api - pulse process' }
TBlSingletonHost classSide >> pulseProcess [
	"Return the pulse loop Process if running, or nil."

	^ self default pulseProcess
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

{ #category : #'api - pulse process' }
TBlSingletonHost classSide >> uiProcessDo: aBlock [
	self
		deprecated: 'Use #default #pulseProcess ifNotNil: instead'
		transformWith: '`@receiver uiProcessDo: `@arg' -> '`@receiver default pulseProcess ifNotNil: `@arg'.

	^ self default pulseProcess ifNotNil: aBlock
]

{ #category : #'host space - accessing' }
TBlSingletonHost classSide >> universe [
	self
		deprecated: 'Use #default #universe instead'
		transformWith: '`@receiver universe' -> '`@receiver default universe'.

	^ self default universe
]
