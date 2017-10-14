examples - shadow
ellipseWithShadow
	<gtExample>
	
	^ BlElement new
		geometry: BlEllipse new;
		size: 300@150;
		relocate: 50@50;
		border: (BlBorder paint: Color black width: 2);
		background: Color red;
		effect: self shadowEffect;
		yourself.