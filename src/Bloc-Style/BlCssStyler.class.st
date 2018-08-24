Class {
	#name : #BlCssStyler,
	#superclass : #BlAbstractStyler,
	#instVars : [
		'styleable',
		'styles',
		'styleProperties',
		'transitions',
		'children',
		'styleClasses',
		'styleId',
		'stylesheets',
		'pseudoClassStates',
		'inlineOrdinalCnt'
	],
	#classInstVars : [
		'DefaultStylesheet'
	],
	#category : 'Bloc-Style-Styler'
}

{ #category : #'as yet unclassified' }
BlCssStyler class >> defaultStylesheet [
	^ DefaultStylesheet
		ifNil: [ DefaultStylesheet := BlStylesheet origin: BlStyleOrigin AUTHOR ]
]

{ #category : #'as yet unclassified' }
BlCssStyler class >> defaultStylesheet: aStylesheet [
	DefaultStylesheet := aStylesheet
]

{ #category : #'as yet unclassified' }
BlCssStyler class >> on: aStyleable [
	^ self basicNew
		styleable: aStyleable;
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
BlCssStyler class >> styleProperties [
	^ #()
]

{ #category : #'computing styles' }
BlCssStyler >> apply [
	| matchingStyles matchingTransitions |
	matchingStyles := self matchingStyleMap.
	matchingTransitions := self matchingTransitions.
	matchingStyles ifNotEmpty:
			[ self styleProperties do: [ :p | |newVal|
					newVal := nil.
					matchingStyles at: p ifPresent: [ :v | newVal := v transition: (matchingTransitions at: p ifAbsent: [ nil ])].
					self perform: (p,':') asSymbol with: (newVal )
					 ]].
	self children do: [ :each | each apply ].
]

{ #category : #accessing }
BlCssStyler >> children [
	^ children
]

{ #category : #accessing }
BlCssStyler >> children: anObject [
	children := anObject
]

{ #category : #private }
BlCssStyler >> compute [
	self stylesheets computeStyleNodes
]

{ #category : #'computing styles' }
BlCssStyler >> declare: anAssoc [
	self forState: nil declare: anAssoc
]

{ #category : #'computing styles' }
BlCssStyler >> forState: aSymbol declare: anAssoc [
|aSelector|

aSelector := BlStyleLocalSelector target:self styleable.
aSymbol ifNotNil:[aSelector pseudoClasses add: (BlState fromSymbol:aSymbol)].
aSelector update.

	self styles
		add:
			(BlStyle new
				selector: aSelector;
				ordinal: (inlineOrdinalCnt := inlineOrdinalCnt +1);
				declaration:
					(BlStylePropertyDeclaration new
						property: anAssoc key;
						value: anAssoc value asBlStyleValue;
						rule: nil;
						yourself))
]

{ #category : #'initialize-release' }
BlCssStyler >> initialize [
	super initialize.
	styles := SortedCollection sortBlock: [ :s1 :s2 | s1 <= s2 ].
	transitions := SortedCollection sortBlock: [ :t1 :t2 | t1 <= t2 ].
	children := IdentitySet new.
	inlineOrdinalCnt := 1000.
	stylesheets := BlStylesheetContainer on: self styleable. 
	pseudoClassStates := BlPseudoClassStates on: self styleable. 
	styleClasses := OrderedCollection new.
	stylesheets add: self class defaultStylesheet.
	self styleable addEventFilter: BlStyleEventListener new.
]

{ #category : #'computing styles' }
BlCssStyler >> matchingStyleMap [
	| thePseudoClassStates matchingStyles |
	thePseudoClassStates := self transitionStates.
	matchingStyles := Dictionary new.
	self styles
		select: [ :s | s matchesStyleable: self styleable pseudoClassStates: thePseudoClassStates ]
		thenDo: [ :s | matchingStyles at: s declaration property put: s declaration value ].
	^ matchingStyles
]

{ #category : #'computing styles' }
BlCssStyler >> matchingTransitions [
	| thePseudoClassStates matchingTrans |
	thePseudoClassStates := self transitionStates.
	matchingTrans := Dictionary new.
	self transitions
		select: [ :t | t matchesStyleable: self styleable pseudoClassStates: thePseudoClassStates ]
		thenDo: [ :t | matchingTrans at: t transition property put: t transition ].
	^ matchingTrans
]

{ #category : #accessing }
BlCssStyler >> pseudoClassStates [
	^ pseudoClassStates
]

{ #category : #accessing }
BlCssStyler >> pseudoClassStates: aPseudoClassStates [
	pseudoClassStates := aPseudoClassStates
]

{ #category : #'computing styles' }
BlCssStyler >> reload [
	stylesheets
		removeAll;
		add: self class defaultStylesheet.
	self
		compute;
		apply
]

{ #category : #accessing }
BlCssStyler >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
BlCssStyler >> styleClasses: anObject [
	styleClasses := anObject
]

{ #category : #accessing }
BlCssStyler >> styleId [
	^ styleId
]

{ #category : #accessing }
BlCssStyler >> styleId: anObject [
	styleId := anObject
]

{ #category : #accessing }
BlCssStyler >> styleProperties [
	^ styleProperties ifNil: [ styleProperties := self class styleProperties ]
]

{ #category : #accessing }
BlCssStyler >> styleable [
	^ styleable  value
]

{ #category : #accessing }
BlCssStyler >> styleable: anObject [
	anObject ifNil: [ styleable value: nil. ^ self ].
	styleable ifNil:[styleable := BlWeakRef new].
	styleable value: anObject.
	anObject styler: self
]

{ #category : #accessing }
BlCssStyler >> styles [
	^ styles
]

{ #category : #accessing }
BlCssStyler >> styles: anObject [
	styles := anObject
]

{ #category : #accessing }
BlCssStyler >> stylesheets [
	^ stylesheets
]

{ #category : #accessing }
BlCssStyler >> stylesheets: aStylesheetContainer [
	stylesheets := aStylesheetContainer
]

{ #category : #'computing styles' }
BlCssStyler >> transitionStates [
	| theStateList parent |
	theStateList := OrderedCollection new.
	parent := self styleable.
	[ parent isNotNil ]
		whileTrue: [ 
			theStateList addFirst: parent pseudoClassStates.
			parent := parent parent ].
	^ theStateList
]

{ #category : #accessing }
BlCssStyler >> transitions [
	^ transitions
]

{ #category : #accessing }
BlCssStyler >> transitions: anObject [
	transitions := anObject
]
