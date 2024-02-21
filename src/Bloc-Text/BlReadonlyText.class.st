Class {
	#name : #BlReadonlyText,
	#superclass : #BlWrappedText,
	#category : #'Bloc-Text-Text'
}

{ #category : #'text - modifications' }
BlReadonlyText >> deleteAll: aCollectionOfIntervals [
	self shouldNotImplement
]

{ #category : #'text - modifications' }
BlReadonlyText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self shouldNotImplement
]

{ #category : #'text - modifications' }
BlReadonlyText >> insertText: aString at: anIndex [
	self shouldNotImplement
]

{ #category : #'text - copying' }
BlReadonlyText >> readonly [
	^ self
]

{ #category : #copying }
BlReadonlyText >> takeInternalRepresentationOf: anotherText [

	self shouldNotImplement 
]

{ #category : #'text - copying' }
BlReadonlyText >> writable [
	"Convert me to a writable text if I am readonly"
	<return: #BlText>

	^ self text
]
