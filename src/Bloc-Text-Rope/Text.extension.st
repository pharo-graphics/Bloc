Extension { #name : 'Text' }

{ #category : '*Bloc-Text-Rope' }
Text >> asRopedText [ 
	"Answer a RopedText with most of the attributes of the receiver.
	This is really ssssllllooowwww"

	| attributeStart lastAttributes attributes removedAttributes ropedText |

	attributeStart := Dictionary new.
	ropedText := self asString asRopedText.
	lastAttributes := IdentitySet new.

	1 to: self size do: [ :i |
		attributes := runs at: i.
		"Handle attributes that are no longer active"
		removedAttributes := lastAttributes difference: attributes asIdentitySet.
		removedAttributes do: [ :attr |
			attr applyToBlText: (ropedText
				from: (attributeStart at: attr) 
				to: i-1).
				attributeStart remove: attr ].

		"Add new attributes"
		attributes do: [ :attr |
			(lastAttributes includes: attr) ifFalse: [ 
				lastAttributes add: attr.
				attributeStart at: attr put: i ] ] ].

		"Add any attributes remaining"
	attributeStart keysAndValuesDo: [ :attr :start |
		attr applyToBlText: (ropedText
			from: start 
			to: self size) ].

	^ropedText
]
