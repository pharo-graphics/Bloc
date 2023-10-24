Extension { #name : 'BlSubRope' }

{ #category : '*Bloc-Text' }
BlSubRope >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode myself on a ByteString stream using the provided Zinc encoder."

	self do: [ :each |
		aZnCharacterEncoder nextPut: each toStream: aWriteStream ]
]
