"
I am the concrete class for writable observable properties.
I am not specialized and i can be used as a generic value holder.
"
Class {
	#name : #BlObjectProperty,
	#superclass : #BlObservableProperty,
	#category : 'Bloc-Property'
}

{ #category : #'instance creation' }
BlObjectProperty class >> on: anOwner named: aSymbol default: aValue [
	^ self new
		name: aSymbol;
		owner: anOwner;
		rawValue: aValue;
		yourself
]

{ #category : #initialization }
BlObjectProperty >> initialize [
	super initialize.
	isValid := true
]

{ #category : #accessing }
BlObjectProperty >> value: anObject [
	self rawValue = anObject ifTrue: [ ^ self ].
	self invalidateDuring: [ 
		self rawValue: anObject.
		self notifyValueChanged ]
]
