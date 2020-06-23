"
BlTextIndex is an abstract class that reifies the index in to a BlRopedText.

See BlTextIndexEOS.

"
Class {
	#name : #BlTextIndex,
	#superclass : #Magnitude,
	#category : #'Bloc-Text-Text-Operator'
}

{ #category : #testing }
BlTextIndex >> < aNumber [ 

	^ self index < aNumber
]

{ #category : #comparing }
BlTextIndex >> = anObject [

	^ self index = anObject
]

{ #category : #converting }
BlTextIndex >> adaptToInteger: anInteger andCompare: aSymbol [

	^ anInteger perform: aSymbol with: self index
]

{ #category : #converting }
BlTextIndex >> adaptToNumber: aNumber andSend: aSymbol [

	^ aNumber perform: aSymbol with: self index
]

{ #category : #converting }
BlTextIndex >> asInteger [ 

	^ self index
]

{ #category : #'instance creation' }
BlTextIndex >> between: min and: max [ 

	^ self index between: min and: max
]

{ #category : #comparing }
BlTextIndex >> hash [ 

	^ self index hash
]

{ #category : #accessing }
BlTextIndex >> index [
	"Answer the receiver's index as a Number"

	self subclassResponsibility 
]

{ #category : #testing }
BlTextIndex >> isTextIndex [

	^ true
]

{ #category : #testing }
BlTextIndex >> isZero [

	^ self index isZero
]

{ #category : #accessing }
BlTextIndex >> max: aMagnitude [

	^ self index > aMagnitude
		ifTrue: [^self]
		ifFalse: [^aMagnitude]
]

{ #category : #accessing }
BlTextIndex >> min: aMagnitude [ 

	^ self index < aMagnitude
		ifTrue: [^self]
		ifFalse: [^aMagnitude]
]
