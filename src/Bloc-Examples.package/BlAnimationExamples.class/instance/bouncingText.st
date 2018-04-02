examples
bouncingText
	"Click on letters to start animation!"
	| letters container animation clickHandler |
	<gtExample>

	letters := 'bloc beta01' collect: [ :aCharacter | self textElement: aCharacter ] as: Array.
	letters withIndexDo: [  :aTextElement :anIndex |
		"change text color according to index in color spectrum"
		aTextElement text: (aTextElement text attributes: { BrTextForegroundAttribute paint: (self colorAt: (anIndex / letters size) asFloat) }) ].

	animation := BlParallelAnimation with: (letters withIndexCollect: [ :aChild :anIndex |
		| jiggle |
		jiggle := self jiggleAnimation.
		jiggle delay: 20 milliSeconds * (anIndex - 1).
		jiggle target: aChild.
		jiggle ]).

	container := self textContainer.
	container addChildren: letters.
	
	clickHandler := nil.
	clickHandler := BlEventHandler
		on: BlClickEvent
		do: [
			container removeEventHandler: clickHandler.
			container addAnimation: animation ].
	container addEventHandler: clickHandler.

	^ self frameContainer addChild: container