"
I represent a string-based element identifier.
"
Class {
	#name : #BlElementNamedId,
	#superclass : #BlElementId,
	#instVars : [
		'name'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #comparing }
BlElementNamedId >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	anObject isBlocElementId ifFalse: [ ^ false ].
	
	"if anObject is of the same class it is faster to directly compare identifiers"
	self class = anObject class
		ifTrue: [ ^ name = anObject identifier ].
	
	"otherwise fallback to the symbol comparison, but watch out, #asSymbol may not be cheap!"
	^ self asSymbol = anObject asSymbol
]

{ #category : #converting }
BlElementNamedId >> asSymbol [

	^ name
]

{ #category : #accessing }
BlElementNamedId >> identifier [

	self
		deprecated: 'Use #name instead'
		transformWith: '`@rcvr identifier' -> '`@rcvr name'.

	^ self name
]

{ #category : #accessing }
BlElementNamedId >> identifier: aSymbol [

	self
		deprecated: 'Use name: instead'
		transformWith: '`@rcvr identifier: `@arg' -> '`@rcvr name: `@arg'.

	self name: aSymbol
]

{ #category : #accessing }
BlElementNamedId >> name [

	^ name
]

{ #category : #accessing }
BlElementNamedId >> name: aSymbol [

	name ifNotNil: [
		(BlImmutableObjectChangeError object: self) signal ].

	name := aSymbol
]
