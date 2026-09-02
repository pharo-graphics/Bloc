"
I provide singleton behavior for classes that represent a shared, system-wide unique instance (such as default host instances).
"
Trait {
	#name : #TBlSingleton,
	#classInstVars : [
		'default'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #cleanup }
TBlSingleton classSide >> cleanUp [
	default := nil
]

{ #category : #accessing }
TBlSingleton classSide >> default [

	^ default ifNil: [
		default := self basicNew initialize; yourself ]
]

{ #category : #'api - lifecycle' }
TBlSingleton classSide >> isRunning [
	self
		deprecated: 'Use #default #isRunning instead'
		transformWith: '`@receiver isRunning' -> '`@receiver default isRunning'.

	^ self default isRunning
]

{ #category : #testing }
TBlSingleton classSide >> isSingleton [
	^ true
]

{ #category : #'driver selection' }
TBlSingleton classSide >> label [
	self
		deprecated: 'Use #default #label instead'
		transformWith: '`@receiver label' -> '`@receiver default label'.

	^ self default label
]

{ #category : #'instance creation' }
TBlSingleton classSide >> new [
	self error: 'Use #default instead'
]
