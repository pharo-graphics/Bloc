Extension { #name : #BlCollectionRope }

{ #category : #'*Bloc-Text' }
BlCollectionRope >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode my collection on a ByteString stream using the provided Zinc encoder."

	aZnCharacterEncoder
		next: collection size
		putAll: collection
		startingAt: 1
		toStream: aWriteStream
]
