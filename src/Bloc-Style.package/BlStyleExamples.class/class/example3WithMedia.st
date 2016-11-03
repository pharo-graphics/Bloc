as yet unclassified
example3WithMedia
	(BlStylesheetLoader  
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;

 }
@media screen and (min-width : 150px){
	.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
		opacity: 1.0;
	 }

}

') inspect