as yet unclassified
example1
	(BlStylesheetLoader  
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;
	background-color : rgba(grey500, 0.5);
	transition: width 2s linear;
	font-family: "Arial";
	font-size: 12pt;
	color: #333333 !important;
	padding: 10px 10px 10px 10px;
	width: 100%;
 }

.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 

	background-color : grey500;
	transition: background-color 2s linear;
	font-family: "Arial";
	font-size: 12pt;
	color: #333333 !important;
	padding: 10px 10px 10px 10px;
	width: 100px;
 }

') inspect