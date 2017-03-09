I represent a simple multiline text element without support of scrolling.

I can measure and render provided immutable styled text; an instance of SpText.
I am the best choice if you want to display small pieces of text.

Public API and Key Messages

- text: to change text I should represent

Example:

   textElement := BlTextElement new.
   textElement text: (SpText fromString: 'Hello world!').
 
Internal Representation and Key Implementation Points.

    Instance Variables
	textLayout:		<SpTextLayout> a measured and splitted text layout. Recreated on each measurement step. Used to render text.
	text:			<SpText> a text I represent


    Implementation Points

Since text measurement is backend specific I use an offscreen canvas to measure text.
See #defaultOffscreenCanvas