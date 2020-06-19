"
I process a given string and replace some characters with special items such as line endings.
I return an array of items (characters or other objects)
"
Class {
	#name : #BlTextStringNormalizer,
	#superclass : #Object,
	#instVars : [
		'cr',
		'lf',
		'nel'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #initialization }
BlTextStringNormalizer >> initialize [

	super initialize.
	cr := Character cr.
	lf := Character lf.
	nel := Character nel.
]

{ #category : #accessing }
BlTextStringNormalizer >> process: aString [
	<return: #String>

	^ String streamContents: [ :writeStream |
		| readStream char |

		readStream := aString readStream.
		[ readStream atEnd ] whileFalse:
			[ char := readStream next.
			"Read streams on in-memory collections know when they're at end-of-stream,
			so no need to check for char == nil here".
			writeStream nextPut: (char = cr ifTrue: 
					[ (readStream peekFor: lf)
						ifTrue: [ nel ]
						ifFalse: [ cr ] ] 
				ifFalse: 
					[ char ])
			 ] ]
]
