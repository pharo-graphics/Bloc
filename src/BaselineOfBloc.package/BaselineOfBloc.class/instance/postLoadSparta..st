actions
postLoadSparta: aSpecLoader
	"Let sparta load as it wish"
	| aGroup |

	"For minimal directive we just need core sparta functionality"
	aGroup := self isMinimal
		ifTrue: [ #core ]
		ifFalse: [ self group ].

	OSPlatform current isUnix64
		"on Unix64 always load development version of Sparta"
		ifTrue: [ aGroup := #development ].

	OSPlatform current isMacOS
		"on OSX always load development version of Sparta"
		ifTrue: [ aGroup := #development ].

	OSPlatform current isWindows
		"on Windows we should always load Moz2D"
		ifTrue: [ aGroup := #development ].

	Metacello new
		baseline: aSpecLoader spec name;
		repository: aSpecLoader spec repositories map keys first;
		load: aGroup