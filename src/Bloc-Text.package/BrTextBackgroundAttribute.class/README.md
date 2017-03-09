I represent a text background attribute.
I am used together with BrText and BrTextStyler to style text.

Public API and Key Messages

- paint: set background paint

Example:

	BrTextBackgroundAttribute paint: Color yellow
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint