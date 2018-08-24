"
I am the abstract class for read-only observable property.
This means that i have to be subclassed to provide an auto-update mechanism.
"
Class {
	#name : #BlReadOnlyProperty,
	#superclass : #BlObservableProperty,
	#category : 'Bloc-Property'
}

{ #category : #'initialize-release' }
BlReadOnlyProperty >> initialize [
	super initialize.
	isValid := true
]
