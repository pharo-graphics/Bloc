Class {
	#name : #BlStylesheetLoader,
	#superclass : #PPCSSGrammar,
	#category : 'Bloc-Style-Util'
}

{ #category : #'grammar value' }
BlStylesheetLoader >> arrayToken [
	^ super arrayToken
		==>
			[ :nodes | BlArrayValue value: (nodes parsedValue first collect: [ :item | item value ]) ]
]

{ #category : #'grammar relation' }
BlStylesheetLoader >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| BlStyleRelation CHILD ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
BlStylesheetLoader >> colorClass [
	^ BlMaterialColor
]

{ #category : #'as yet unclassified' }
BlStylesheetLoader >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'as yet unclassified' }
BlStylesheetLoader >> createSimpleSelector: anItem [
	| theSelector |
	theSelector := BlStyleSimpleSelector new
		name: anItem first first;
		id: anItem first second;
		yourself.
	theSelector styleClasses addAll: anItem first third.
	theSelector pseudoClasses addAll: anItem second.
	^ theSelector
		update;
		yourself
]

{ #category : #'grammar declaration' }
BlStylesheetLoader >> declaration [
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ BlStyleTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ BlStylePropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
]

{ #category : #'grammar declaration' }
BlStylesheetLoader >> declarations [
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]
]

{ #category : #'grammar relation' }
BlStylesheetLoader >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| BlStyleRelation DESCENDANT ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> floatNumber [
	^ super floatNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> function [
	^ super function
		==> [ :nodes | 
			{nodes first.
			(nodes third reject: [ :item | item = $, ])} ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> functionToken [
	^ super functionToken
		==>
			[ :nodes | 
			| val funct args |
			val := nodes parsedValue.
			funct := val first.
			args := val second.
			self perform: ('helper' , funct asCamelCase) asSymbol asMutator with: args ]
]

{ #category : #helper }
BlStylesheetLoader >> helperRgba: args [
	args first value isColor
		ifTrue: [ ^ BlColorValue value: (args first value alpha: args last value) ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> hexcolorToken [
	^ super hexcolorToken
		==>
			[ :nodes | BlColorValue value: (self colorClass fromHexString: nodes inputValue allButFirst) ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> identToken [
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(self colorClass respondsTo: val)
				ifTrue: [ BlColorValue value: (self colorClass perform: val) ]
				ifFalse: [ BlSymbolValue value: val ] ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> intNumber [
	^ super intNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> media [
	^ super media
		==>
			[ :nodes | 
			BlStyleMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaDefaultTypeWithConditions [
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			BlStyleMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaTypeToken [
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]
]

{ #category : #'grammar media' }
BlStylesheetLoader >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			BlStyleMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> numberToken [
	^ super numberToken ==> [ :nodes | BlNumberValue value value: nodes parsedValue ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
BlStylesheetLoader >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken
		==> [ :nodes | BlState fromSymbol: nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
BlStylesheetLoader >> rule [
	^ super rule
		==> [ :nodes | 
			BlStyleRule new
				selectors: nodes first;
				declarations: nodes third;
				yourself ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> selector [
	^ super selector
		==>
			[ :nodes | 
			| finalSelector theSelectors theRelations |
			theSelectors := OrderedCollection new.
			theRelations := OrderedCollection new.
			nodes
				withIndexDo:
					[ :item :index | 
					index % 2 = 1
						ifTrue: [ theSelectors add: (self createSimpleSelector: item) ]
						ifFalse: [ theRelations add: item ] ].
			theSelectors size = 1
				ifTrue: [ finalSelector := theSelectors first ]
				ifFalse:
					[ finalSelector := BlStyleCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]
]

{ #category : #'grammar selector' }
BlStylesheetLoader >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> stringToken [
	^ super stringToken ==> [ :nodes | BlStringValue value value: nodes parsedValue ]
]

{ #category : #grammar }
BlStylesheetLoader >> stylesheet [
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := BlStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]
]

{ #category : #'grammar value' }
BlStylesheetLoader >> typedValue [
	^ super typedValue
		==>
			[ :nodes | 
			BlStyleValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]
]
