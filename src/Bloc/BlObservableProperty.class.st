"
I am the abstract class for properties that can be observed.
I manage a list of change listener and i notify it when my value changes.
My subclasses can define a specific behavior during invalidation.
"
Class {
	#name : #BlObservableProperty,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'name',
		'owner',
		'rawValue',
		'changeListeners',
		'isValid',
		'binding'
	],
	#category : 'Bloc-Property'
}

{ #category : #'as yet unclassified' }
BlObservableProperty class >> on: anOwner [
	^ self new
		owner: anOwner;
		yourself
]

{ #category : #'as yet unclassified' }
BlObservableProperty class >> on: anOwner named: aSymbol [
	^ self new
		name: aSymbol;
		owner: anOwner;
		yourself
]

{ #category : #'change management' }
BlObservableProperty >> addChangeListener: aListener [

	self
		assert: [ (changeListeners includes: aListener) not ]
		description: [ 'Listener must not be already added!' ].

	changeListeners := changeListeners copyWith: aListener
]

{ #category : #binding }
BlObservableProperty >> bindOn: aProperty [
	self bindOn: aProperty bidirectional: false
]

{ #category : #binding }
BlObservableProperty >> bindOn: aProperty bidirectional: aBoolean [

	self unbind.
	binding := BlPropertyBinding from: aProperty to: self bidirectional: aBoolean
]

{ #category : #accessing }
BlObservableProperty >> defaultName [
	self subclassResponsibility  
]

{ #category : #'change management' }
BlObservableProperty >> hasChangeListeners [
	^ changeListeners isNotEmpty
]

{ #category : #'initialize-release' }
BlObservableProperty >> initialize [
	super initialize.
	changeListeners := #()
]

{ #category : #private }
BlObservableProperty >> invalidateDuring: aBlock [
	"Make sure that the change propagation is not active while executing the parameter."
	isValid ifFalse: [ ^ self ].
	isValid := false.
	aBlock ensure: [ isValid := true ]
]

{ #category : #'change management' }
BlObservableProperty >> invalidated [
	"nothing here. Hook for subclasses"
]

{ #category : #accessing }
BlObservableProperty >> name [
	^ name ifNil: [ name := self defaultName ]
]

{ #category : #accessing }
BlObservableProperty >> name: anObject [
	name := anObject
]

{ #category : #private }
BlObservableProperty >> notifyValueChanged [
	| theListeners aValue |
	self invalidated.
	
	"changeListeners is *immutable* array so there is no need to make a copy
	of existing listeners, we just need to store a reference to the array
	for the case if one of the listeners will be removed as the result of some action
	by any notified listener"
	theListeners := changeListeners.
	aValue := self value.
	theListeners do: [ :cl | cl valueChanged: aValue ]
]

{ #category : #'change management' }
BlObservableProperty >> onChangedDo: aBlock [
	self addChangeListener: (BlOnChangeListener do: aBlock)
]

{ #category : #accessing }
BlObservableProperty >> owner [
	^ owner
]

{ #category : #accessing }
BlObservableProperty >> owner: anObject [
	owner := anObject
]

{ #category : #printing }
BlObservableProperty >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: 'name:';
		nextPutAll: self name;
		nextPutAll: ', value:';
		print: self rawValue;
		nextPut: $)
]

{ #category : #private }
BlObservableProperty >> rawValue [
	^ rawValue
]

{ #category : #private }
BlObservableProperty >> rawValue: anObject [
	rawValue := anObject
]

{ #category : #'change management' }
BlObservableProperty >> removeAllChangeListeners [
	changeListeners := #()
]

{ #category : #'change management' }
BlObservableProperty >> removeChangeListener: aListener [
	"Remove the argument from the list of listeners"

	self
		assert: [ (changeListeners includes: aListener) ]
		description: [ 'Listener must exist!' ].
	
	changeListeners := changeListeners copyWithout: aListener
]

{ #category : #binding }
BlObservableProperty >> unbind [
	binding ifNotNil: #unbind.
	binding := nil
]

{ #category : #accessing }
BlObservableProperty >> value [
	^ self rawValue
]
