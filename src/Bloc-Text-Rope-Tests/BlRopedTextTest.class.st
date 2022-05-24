Class {
	#name : #BlRopedTextTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Rope-Tests'
}

{ #category : #running }
BlRopedTextTest >> helloWorldWithAttributes [

	| aText |
	aText := BlRopedText string: 'Hello World'.
	(aText from: 1 to: 5) foreground: Color red.
	(aText from: 7 to: 11) foreground: Color blue.
	^ aText
]

{ #category : #tests }
BlRopedTextTest >> testUTF8RopedText [

	| utf8Array |
	utf8Array := ByteArray streamContents: [ :stream |
		self helloWorldWithAttributes
			encodeOn: stream
			with: ZnUTF8Encoder default ].
	
	self assert: utf8Array equals: 'Hello World' utf8Encoded
]

{ #category : #tests }
BlRopedTextTest >> testUTF8SubRope [

	| utf8Array aNumber |
	aNumber := 7.
	utf8Array := ByteArray streamContents: [ :stream |
		(self helloWorldWithAttributes first: aNumber)
			encodeOn: stream
			with: ZnUTF8Encoder default ].
	
	self assert: utf8Array equals: ('Hello World' first: aNumber) utf8Encoded
]
