Class {
	#name : #BlAssertionsTraitTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #tests }
BlAssertionsTraitTest >> testAllAssertDescriptionUseDebugTrait [
	| senders classes superclasses blocClasses |
	self skip.
	self flag: #toRemove.
	"keep the logic to remove it cleanly."
	
	senders := (#assert:description: senders
		select: [ :aSender | aSender method isGTExampleMethod not ])
		select: [ :aSender | ((aSender methodClass withAllSuperclasses flatCollect: #traits) includes: TBlDebug) not ].

	classes := senders collect: #methodClass as: Set.
	superclasses := classes flatCollect: [ :aClass | aClass withAllSuperclasses select: [ :aSuperClass | aSuperClass superclass == Object ] ] as: Set.

	blocClasses := superclasses select: [ :aClass |
		| packageName |
		packageName := aClass package name.
		packageName includesSubstring: 'Bloc' ].
	
	self assert: blocClasses isEmpty
]

{ #category : #tests }
BlAssertionsTraitTest >> testAllAssertUseDebugTrait [
	| senders classes superclasses blocClasses |
	self skip.
	self flag: #toRemove.
	"keep the logic to remove it cleanly."
	senders := (#assert: senders
		select: [ :aSender | aSender method isGTExampleMethod not ])
		select: [ :aSender | ((aSender methodClass withAllSuperclasses flatCollect: #traits) includes: TBlDebug) not ].

	classes := senders collect: #methodClass as: Set.
	superclasses := classes flatCollect: [ :aClass | aClass withAllSuperclasses select: [ :aSuperClass | aSuperClass superclass == Object ] ] as: Set.

	blocClasses := superclasses select: [ :aClass |
		| packageName |
		packageName := aClass package name.
		packageName includesSubstring: 'Bloc' ].
	
	self assert: blocClasses isEmpty
]
