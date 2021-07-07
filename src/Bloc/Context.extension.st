Extension { #name : #Context }

{ #category : #'*Bloc' }
Context >> blocDefiningMethod [
	"Return a CompiledMethod this context belongs to"
	| anOuterMostContext aCompiledCode |
	
	anOuterMostContext := self outerMostContext.
	
	"In Pharo9 Context>>#method was renamed to Context>>#compiledCode because it can return CompiledBlock, not just CompiledMethod"
	aCompiledCode := (anOuterMostContext respondsTo: #compiledCode)
		ifTrue: [ anOuterMostContext compiledCode ]
		ifFalse: [ anOuterMostContext method ].
		
	^ aCompiledCode isCompiledMethod
		ifTrue: [ aCompiledCode ]
		ifFalse: [ anOuterMostContext blocDefiningMethod ]
]

{ #category : #'*Bloc' }
Context >> blocMethodDefinition [
	"Return a Ring method definition for the CompiledMethod this context belongs to"

	^ self blocDefiningMethod asRingDefinition
]
