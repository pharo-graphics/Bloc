Extension { #name : #Context }

{ #category : #'*Bloc' }
Context >> blocDefiningMethod [
	"Return a CompiledMethod this context belongs to"
	| outerMostContext aCompiledCode |
	
	outerMostContext := self outerContext.
	outerMostContext ifNil: [ 
		aCompiledCode := self compiledCode.
		^ aCompiledCode isCompiledMethod
			ifTrue: [ aCompiledCode ]
			ifFalse: [ aCompiledCode method ] ].
		
	aCompiledCode := outerMostContext compiledCode.
		
	^ aCompiledCode isCompiledMethod
		ifTrue: [ aCompiledCode ]
		ifFalse: [ outerMostContext blocDefiningMethod ]
]

{ #category : #'*Bloc' }
Context >> blocMethodDefinition [
	"Return a Ring method definition for the CompiledMethod this context belongs to"

	^ self blocDefiningMethod asRingDefinition
]
