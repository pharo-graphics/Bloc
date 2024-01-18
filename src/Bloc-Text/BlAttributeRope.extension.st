Extension { #name : #BlAttributeRope }

{ #category : #'*Bloc-Text' }
BlAttributeRope >> encodeOn: aWriteStream with: aZnCharacterEncoder [ 
	"Encode my rope on a ByteString stream using the provided Zinc encoder."

	rope encodeOn: aWriteStream with: aZnCharacterEncoder
]
