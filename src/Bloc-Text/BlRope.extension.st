Extension { #name : #BlRope }

{ #category : #'*Bloc-Text' }
BlRope >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode myself on a ByteString stream using the provided Zinc encoder."

	^ self subclassResponsibility
]
