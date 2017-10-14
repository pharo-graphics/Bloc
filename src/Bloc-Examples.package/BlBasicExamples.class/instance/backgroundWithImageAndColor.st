examples - background
backgroundWithImageAndColor
	<gtExample>
	
	^ BlBackground builder
		image: PolymorphSystemSettings pharoLogoForm;
		opacity: 0.6; "changes opacity of pharo logo"
		image: (Smalltalk ui icons iconNamed: #info);
		paint: Color gray;
		opacity: 0.2; "changes opacity of gray paint"
		build