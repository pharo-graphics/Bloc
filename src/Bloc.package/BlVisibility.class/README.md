I represent a visibility type and can be
	"gone" - element is not visible and does not take any space in layout
	"hidden" - element is not visible but participates in layout
	"visible" - normal visiblity

Visibility is independent from opacity, which is just a visual property.
Invisible (gone or hidden) elements don't receive event, while transparent (opacity = 0) do receive.

If you want to make element transparent and preserve ability to handle events set opacity to zero:
==element opacity: 0==