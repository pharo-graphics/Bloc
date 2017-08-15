I represent a font weight attribute.
I am used together with BrText and BrTextStyler to style text.

Public API and Key Messages

- weight: set font weight in absolute units (100, 200, 400, 600, 800)

Example:

	BrFontWeightAttribute weight: 400.
	BrFontWeightAttribute bold.
	BrFontWeightAttribute normal.
	BrFontWeightAttribute thin
 
Internal Representation and Key Implementation Points.

    Instance Variables
	weight		<Number> 