"
I am a class group to be browsed using Nautilus
"
Class {
	#name : #NautilusClassGroup,
	#superclass : #Group,
	#instVars : [
		'classes'
	],
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #accessing }
NautilusClassGroup class >> named: aString classes: aCollectionOfClasses [
	^ self new
		name: aString;
		classes: aCollectionOfClasses;
		yourself
]

{ #category : #accessing }
NautilusClassGroup >> classes [
	^ classes
]

{ #category : #accessing }
NautilusClassGroup >> classes: aCollection [
	classes := aCollection asArray
]

{ #category : #accessing }
NautilusClassGroup >> elements [
	^ classes sorted
]

{ #category : #accessing }
NautilusClassGroup >> hasClassNamed: aClassName [
	^ self classes anySatisfy: [ :class | class name = aClassName ]
]

{ #category : #initialization }
NautilusClassGroup >> initialize [
	super initialize.

	classes := #()
]
