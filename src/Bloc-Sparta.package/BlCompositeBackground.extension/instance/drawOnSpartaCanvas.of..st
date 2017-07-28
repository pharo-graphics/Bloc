*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement
	"Draw a background of a given element on a provided Sparta Canvas"
	aCanvas layer
		alpha: self opacity;
		when: [ (self opacity closeTo: 1.0) not ]
		during: [ backgrounds do: [ :aBackground | aBackground drawOnSpartaCanvas: aCanvas of: anElement ] ]