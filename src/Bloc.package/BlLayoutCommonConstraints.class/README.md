I represent  layout constraints common to all layout.

I am responsible for storing and validating layout constraints. All my properties are meant to be immutable, so I always return an actual reference when requested.

I provide a way to support layout specific constraints with help of association layout class -> layout specific constraints. It is guaranteed that I can be used by any kind of layout.

I am used by BlElement and play a role of its layout constraints. Layouts referer to me in order to query layout constraints.

Public API and Key Messages

- at: return constraints specific for a layout
- margin return element's margin
- padding return element's padding

   BlCommonConstraints new
	maxHeight: 200;
	minWidth: 50
 
Internal Representation and Key Implementation Points.

    Instance Variables
	constraints:		<Dictionary>
	margin:			<BlInset>
	maxHeight:		<Number>
	maxWidth:		<Number>
	minHeight:		<Number>
	minWidth:		<Number>
	padding:		<BlInset>


    Implementation Points