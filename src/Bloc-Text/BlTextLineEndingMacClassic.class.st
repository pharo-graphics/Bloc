"
On the Mac Classic (Mac systems using any system prior to Mac OS X), line-endings are terminated with a single carriage return (\r or CR).
Mac OS X uses the UNIX convention.
"
Class {
	#name : #BlTextLineEndingMacClassic,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingMacClassic >> asString [
	^ String cr
]

{ #category : #testing }
BlTextLineEndingMacClassic >> matches: aCurrentCharacter and: aNextCharacter [
	<return: #Boolean>

	^ aCurrentCharacter = Character cr
]
