I provide composition ability of multiple ===BlBackground===.
I am useful when an Element should have both paint and image backgrounds.

Note: composed backgrounds are rendered in the same order they are defined in a composition. So for example if I was created as follows:

BlCompositeBackground withAll: {
	BlPaintBackground paint: Color red.
	BlImageBackground image: PolymorphSystemSettings pharoLogoForm
} 

then image background will appear on top of paint background.

It is more convenient to create a composite background using ===BlBackgroundBuilder===

Opacity example:

	BlCompositeBackground new
		opacity: 0.5;
		withAll: {
			BlPaintBackground paint: Color red.
			BlImageBackground image: PolymorphSystemSettings pharoLogoForm
		} 