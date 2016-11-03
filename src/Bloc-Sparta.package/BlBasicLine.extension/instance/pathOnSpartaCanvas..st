*Bloc-Sparta
pathOnSpartaCanvas: aCanvas
	"Returns path or builds it if nil"

	^ aCanvas shape
		line: (self from translateBy: self position negated)
		to: (self to translateBy: self position negated)