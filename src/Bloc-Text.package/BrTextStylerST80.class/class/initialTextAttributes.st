initialization
initialTextAttributes
	| theAttributes |

	theAttributes := IdentityDictionary new.

	self styleTable do: [ :aStyleRow |
		| aStyle emphasis attrArray color |

		aStyle := aStyleRow first.
		color := Color colorFrom: (aStyleRow at: 2 ifAbsent: [ nil ]).
		emphasis := (Array with: (aStyleRow at: 3 ifAbsent: [ #normal ])) flattened.

		attrArray := self
			attributeArrayForColor: color
			emphasis: emphasis.

		theAttributes at: aStyle put: attrArray ].

	^ theAttributes