Class {
	#name : 'BlTextNonPrintableCharacterPrinter',
	#superclass : 'Object',
	#classVars : [
		'CharacterMap'
	],
	#category : 'Bloc-Text-Text-Support',
	#package : 'Bloc-Text',
	#tag : 'Text-Support'
}

{ #category : 'accessing' }
BlTextNonPrintableCharacterPrinter class >> characterMap [

	^ CharacterMap ifNil: [ CharacterMap := { 
		Character tab -> '<TAB>'.
		Character cr -> '<CR>'.
		Character lf -> '<LF>'.
		Character nel -> '<CRLF>' } asDictionary ]
]

{ #category : 'printing' }
BlTextNonPrintableCharacterPrinter class >> print: aString [

	^ String streamContents: [ :stream |
		self print: aString on: stream ]
]

{ #category : 'printing' }
BlTextNonPrintableCharacterPrinter class >> print: aString on: aStream [

	aString do: [ :ch |
		self characterMap
			at: ch
			ifPresent: [ :mapping | aStream << mapping ]
			ifAbsent: [ aStream nextPut: ch ] ]
]
