actions
postLoadSparta: aSpecLoader
	"Let sparta load as it wish"
	| aGroup |

	"For minimal directive we just need core sparta functionality"
	aGroup := self isMinimal
		ifTrue: [ #core ]
		ifFalse: [ self group ].

	Metacello new
		baseline: aSpecLoader spec name;
		repository: aSpecLoader spec repositories map keys first;
		load: aGroup