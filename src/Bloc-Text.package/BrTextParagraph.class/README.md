I am an abstract text paragraph. My main role is to measure text according to given additional properties or constraints and prepare it for rendering.

The most important properties are maximal width and height. Maximal width is used to wrap a line of text in multiple lines while maximal height prevents text from exceeding an element's boundaries.

Once measurement is done users may ask for computed text extent by sending #extent message.
The measured text layout can be rendered on Canvas by sending #renderOn: with canvas as argument to me.

Public API and Key Messages

- text: initialize me with a given text
- measureOn: measure given rope using provided canvas
- renderOn: render text layout on given canvas
- extent - return measured text extent
- width - return measured text width
- height - return measured text height
 
Internal Representation and Key Implementation Points.

    Instance Variables
	text:		<BrText>
	maxHeight:		<Number>
	maxWidth:		<Number>
	height:		<Number>
	width:		<Number>
	end:		<Number>
	autoRelease:		<Boolean>

    Implementation Points