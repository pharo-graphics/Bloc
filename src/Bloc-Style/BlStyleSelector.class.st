Class {
	#name : #BlStyleSelector,
	#superclass : #Object,
	#instVars : [
		'rule',
		'specificity',
		'matchOnId',
		'matchOnName',
		'matchOnStyleClass'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStyleSelector class >> from: anObject [
	anObject isSymbol
		ifTrue: [ ^ self fromSymbol: anObject ].
	(anObject isArray and: [ anObject size = 1 ])
		ifTrue: [ ^ self fromSymbol: anObject first ].
	anObject isArray
		ifTrue: [ ^ self fromSymbols: anObject ]
]

{ #category : #'as yet unclassified' }
BlStyleSelector class >> fromSymbol: aSymbol [
	| parts selector |
	parts := BlStyleHelper splitSelectorSymbol: aSymbol.
	selector := BlStyleSimpleSelector new
		name: nil;
		styleClasses: {parts first asSymbol};
		id: nil;
		yourself.
	parts size > 1
		ifTrue:
			[ 
			selector pseudoClasses
				addAll: (parts allButFirst collect: [ :each | BlState fromSymbol: each asSymbol ]) ].
	selector update.
	^ selector
]

{ #category : #'as yet unclassified' }
BlStyleSelector class >> fromSymbols: aSymbolList [
	| selectors relationships |
	selectors := OrderedCollection new.
	relationships := OrderedCollection new.
	aSymbolList
		do:
			[ :aSymb | 
			aSymb = #>
				ifTrue: [ relationships add: BlStyleRelation CHILD ]
				ifFalse:
					[ 
					(aSymb = aSymbolList first) not
						ifTrue: [ relationships add: BlStyleRelation DESCENDANT ].
					selectors add: (self fromSymbol: aSymb) ] ].
	^ (BlStyleCompoundSelector selectors: selectors relationships: relationships)
		update;
		yourself
]

{ #category : #testing }
BlStyleSelector >> isSimpleSelector [
	^ false
]

{ #category : #testing }
BlStyleSelector >> matchesOnId [
	^ matchOnId
]

{ #category : #testing }
BlStyleSelector >> matchesOnName [
	^ matchOnName 
]

{ #category : #testing }
BlStyleSelector >> matchesOnStyleClass [ 
	^ matchOnStyleClass 
]

{ #category : #testing }
BlStyleSelector >> matchesStyleable: aStyleable [
	self subclassResponsibility 
]

{ #category : #testing }
BlStyleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self subclassResponsibility 
]

{ #category : #testing }
BlStyleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
BlStyleSelector >> origin [
	^ self rule origin
]

{ #category : #accessing }
BlStyleSelector >> rule [
	^ rule
]

{ #category : #accessing }
BlStyleSelector >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
BlStyleSelector >> specificity [
	^ specificity
]

{ #category : #updating }
BlStyleSelector >> update [
	self updateMatching.
	self updateSpecificity 
]

{ #category : #updating }
BlStyleSelector >> updateMatching [
	self subclassResponsibility 
]

{ #category : #updating }
BlStyleSelector >> updateSpecificity [
	self subclassResponsibility
]
