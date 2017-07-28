I am a BlBackground builder.

Example:

BlBackground builder
	paint: (BlRadialGradientPaint new
		stops: { 0 -> Color blue . 1 -> Color red};
		center: 100@100;
		radius: 200);
	opacity: 0.2; "change opacity of paint background"
	image: PolymorphSystemSettings pharoLogoForm;
	opacity: 0.6; "change opacity of image background"
	build