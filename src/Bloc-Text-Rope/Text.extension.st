Extension { #name : 'Text' }

{ #category : '*Bloc-Text-Rope' }
Text >> asRopedText [ 
	"Answer a RopedText with most of the attributes of the receiver.
	This is really ssssllllooowwww"

	| startIndexByAttribute aRopedText |
	startIndexByAttribute := Dictionary new.
	aRopedText := self asString asRopedText.

	runs withIndexDo: [ :attributes :index |
		| attributesThatEnd |

		"Apply ending attributes"
		attributesThatEnd := startIndexByAttribute keys copyWithoutAll: attributes.
		attributesThatEnd do: [ :eachAttribute |
			eachAttribute applyToBlText: (aRopedText
				from: (startIndexByAttribute at: eachAttribute) 
				to: index - 1).
			startIndexByAttribute removeKey: eachAttribute ].

		"Remember starting attributes"
		attributes do: [ :eachAttribute |
			(startIndexByAttribute includesKey: eachAttribute) ifFalse: [
				startIndexByAttribute at: eachAttribute put: index ] ] ].

	"Apply any remaining attribute"
	startIndexByAttribute keysAndValuesDo: [ :eachAttribute :start |
		eachAttribute applyToBlText: (aRopedText
			from: start 
			to: self size) ].

	^ aRopedText
]
