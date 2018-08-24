Class {
	#name : #BlStyleSimpleSelector,
	#superclass : #BlStyleSelector,
	#instVars : [
		'name',
		'styleClasses',
		'id',
		'pseudoClasses',
		'idCount',
		'styleClassCount',
		'nameCount',
		'pseudoClassCount'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #testing }
BlStyleSimpleSelector >> = aSelector [
	^ (aSelector isSimpleSelector) and:[
		((self name = aSelector name 
		and: [ self id = aSelector id ]) 
		and: [ self pseudoClasses = aSelector pseudoClasses ])
		and: [ self styleClasses = aSelector styleClasses ]]
]

{ #category : #accessing }
BlStyleSimpleSelector >> id [
	^ id
]

{ #category : #accessing }
BlStyleSimpleSelector >> id: anObject [
	id := anObject
]

{ #category : #accessing }
BlStyleSimpleSelector >> idCount [
	^ idCount
]

{ #category : #accessing }
BlStyleSimpleSelector >> initialize [
	super initialize.
	pseudoClasses := OrderedCollection new.
	styleClasses := OrderedCollection new
]

{ #category : #testing }
BlStyleSimpleSelector >> isSimpleSelector [
	^ true
]

{ #category : #testing }
BlStyleSimpleSelector >> matchesPseudoClasseState: aPseudoClassState [
	^ aPseudoClassState includesAll: pseudoClasses
]

{ #category : #testing }
BlStyleSimpleSelector >> matchesStyleClasses: aStyleClassList [
	^ aStyleClassList includesAll: styleClasses
]

{ #category : #testing }
BlStyleSimpleSelector >> matchesStyleable: aStyleable [
	self matchesOnName
		ifTrue: [ (self nameMatches: aStyleable className) ifFalse: [ ^ false ] ].
	self matchesOnId
		ifTrue: [self id = aStyleable styleId ifFalse: [ ^ false ] ].
	self matchesOnStyleClass
		ifTrue:[(self matchesStyleClasses: aStyleable styleClasses ) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #testing }
BlStyleSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: aPseudoClassStateList size
]

{ #category : #testing }
BlStyleSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	(self matchesStyleable: aStyleable)
		ifFalse: [ ^ false ].
	aPseudoClassStateList
		ifNotEmpty:
			[ :c | (self matchesPseudoClasseState: (c last))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
BlStyleSimpleSelector >> name [
	^ name
]

{ #category : #accessing }
BlStyleSimpleSelector >> name: anObject [
	name := anObject
]

{ #category : #accessing }
BlStyleSimpleSelector >> nameCount [
	^ nameCount
]

{ #category : #testing }
BlStyleSimpleSelector >> nameMatches: aClassName [
	matchOnName
		ifFalse: [ ^ false ].
	^ name = aClassName
]

{ #category : #'as yet unclassified' }
BlStyleSimpleSelector >> printOn: aStream [
	self name ifNotNil: [ :n | aStream nextPutAll: n ].
	self id ifNotNil: [ :i | aStream nextPutAll: i ].
	self styleClasses
		ifNotEmpty: [ :cls | 
			aStream
				nextPut: $.;
				nextPutAll: (cls joinUsing: '.') ].
	self pseudoClasses
		ifNotEmpty: [ :pcls | 
			aStream
				nextPut: $:;
				nextPutAll: (pcls joinUsing: ':') ]
]

{ #category : #accessing }
BlStyleSimpleSelector >> pseudoClassCount [
	^ pseudoClassCount
]

{ #category : #accessing }
BlStyleSimpleSelector >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #accessing }
BlStyleSimpleSelector >> pseudoClasses: anObject [
	pseudoClasses := anObject
]

{ #category : #accessing }
BlStyleSimpleSelector >> styleClassCount [
	^ styleClassCount
]

{ #category : #accessing }
BlStyleSimpleSelector >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
BlStyleSimpleSelector >> styleClasses: anObject [
	styleClasses := anObject
]

{ #category : #updating }
BlStyleSimpleSelector >> updateMatching [
	matchOnId := id isNotNil and: [ id isNotEmpty ].
	matchOnName := name isNotNil and: [ name isNotEmpty and: [ (name = '*') not ] ].
	matchOnStyleClass := styleClasses isNotEmpty.
]

{ #category : #updating }
BlStyleSimpleSelector >> updateSpecificity [
	idCount := self matchesOnId asBit.
	styleClassCount := self styleClasses size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := self matchesOnName asBit.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
