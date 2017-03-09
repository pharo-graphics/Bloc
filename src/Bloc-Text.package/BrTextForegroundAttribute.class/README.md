I represent a text foreground attribute.
I am used together with BrText and BtTextStyler to style text.

Public API and Key Messages

- paint: set foreground paint

Example:

	BrTextForegroundAttribute paint: Color blue
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint