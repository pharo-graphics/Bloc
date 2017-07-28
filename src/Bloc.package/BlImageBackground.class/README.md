I am a special image type background given as Form.

Note: I am never #isTransparent even if all Form pixels are transparent. The reason for this is the fact that ther is no fast way to detect if a Form is completly transparent without checking all pixels.

Example:

	BlImageBackground image: ((Form extent: 50@50 depth: 32) fillColor: Color blue)
	
	or
	
	BlImageBackground new
		image: PolymorphSystemSettings pharoLogoForm;
		yourself
		
Opacity example:

	BlImageBackground new
		opacity: 0.5;
		image: PolymorphSystemSettings pharoLogoForm;
		yourself