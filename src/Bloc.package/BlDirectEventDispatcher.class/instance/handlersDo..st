api - accessing
handlersDo: aBlock
	"Evaulate a given block with every event handler as an argument"

	handlers ifNotNil: [ :aRegistry | aRegistry handlers do: aBlock ]