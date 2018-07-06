api - instantiation
text: aBrText
	"Construct me with a given text.
	Note, that I can be only initialized once.
	Once done, you need to measure me (build lines or words) providing an instance of Canvas as context provider.
	For that send me #measureOn: message with canvas as an argument"

	self
		assert: [ text = BlText empty ]
		description: [ 'I am immutable! You should create a new instance or #reset me' ].

	text := aBrText