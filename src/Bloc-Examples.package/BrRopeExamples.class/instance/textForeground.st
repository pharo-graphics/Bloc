examples
textForeground
	<gtExample>
	| text |

	"space between `Hello` and `world` is not attributed"
	text := 'Hello world' asRopedText.
	(text from: 1 to: 5) foreground: Color blue.
	(text from: 7 to: 11) foreground: Color red.

	self assert: text rope isConcatenation.
	self assert: text rope left isConcatenation.
	self assert: text rope left left size equals: 5.
	self assert: (text rope left left isKindOf: BlAttributeRope).
	self assert: text rope left left attributes asArray equals: { BrTextForegroundAttribute paint: Color blue }.
	self assert: (text rope right isKindOf: BlAttributeRope).
	self assert: text rope right attributes asArray equals: { BrTextForegroundAttribute paint: Color red }.

	^ text