Class {
	#name : #BlReadonlyText,
	#superclass : #BlWrappedText,
	#category : 'Bloc-Text-Text'
}

{ #category : #'text - modifications' }
BlReadonlyText >> delete: aStart to: anEnd [
	"Read only text can not be modified"
]

{ #category : #'text - modifications' }
BlReadonlyText >> insertString: aString at: anIndex [
	"Read only text can not be modified"
]

{ #category : #'text - modifications' }
BlReadonlyText >> insertText: aString at: anIndex [
	"Read only text can not be modified"
]

{ #category : #'text - copying' }
BlReadonlyText >> readonly [
	^ self
]

{ #category : #'text - copying' }
BlReadonlyText >> writable [
	"Convert me to a writable text if I am readonly"
	<return: #BlText>

	^ self text
]
