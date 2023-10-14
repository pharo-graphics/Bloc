Extension { #name : 'BlConcatenationRope' }

{ #category : '*Bloc-Text' }
BlConcatenationRope >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode my two branches on a ByteString stream using the provided Zinc encoder."

	left encodeOn: aWriteStream with: aZnCharacterEncoder.
	right encodeOn: aWriteStream with: aZnCharacterEncoder
]
