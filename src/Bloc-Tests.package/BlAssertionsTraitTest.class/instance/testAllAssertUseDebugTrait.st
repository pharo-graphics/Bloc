tests
testAllAssertUseDebugTrait
	| senders classes superclasses blocClasses |
	
	senders := #assert: senders
		select: [ :aSender | ((aSender methodClass withAllSuperclasses flatCollect: #traits) includes: TBlDebug) not ].

	classes := senders collect: #methodClass as: Set.
	superclasses := classes flatCollect: [ :aClass | aClass withAllSuperclasses select: [ :aSuperClass | aSuperClass superclass == Object ] ] as: Set.

	blocClasses := superclasses select: [ :aClass |
		| packageName |
		packageName := aClass package name.
		packageName includesSubstring: 'Bloc' ].
	
	self assert: blocClasses isEmpty