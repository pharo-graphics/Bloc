Class {
	#name : #BlStyleExamples,
	#superclass : #Object,
	#category : 'Bloc-Style-Examples'
}

{ #category : #'as yet unclassified' }
BlStyleExamples class >> buttons [

	^ BlStylesheetLoader
		parse:
			'
	BlButton { 
		background-color : green600;
		box-shadow: 0px 1px 5px rgba(grey500,0.5);
		border-radius : 3px;
		color : white;
		font-size: 12px;
	}
	BlButton:hovered{
		background-color : green500;
		box-shadow: 0px 1px 6px rgba(grey500,0.8);
	}
	BlButton:pressed{
		background-color : green400;
	}
	BlButton .ripple{
		transition : background-color 100ms linearColor;
		transition : radius 100ms linear;
		background-color : rgba(grey300, 0);
		radius : 5%;
	}
	
	
	'
]

{ #category : #'as yet unclassified' }
BlStyleExamples class >> example1 [
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
]

{ #category : #'as yet unclassified' }
BlStyleExamples class >> example2 [
	(BlStylesheetLoader  
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;

 }') inspect
]

{ #category : #'as yet unclassified' }
BlStyleExamples class >> example3WithMedia [
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
]

{ #category : #'as yet unclassified' }
BlStyleExamples class >> example4 [
	^(BlStylesheetLoader  
		parse:'
		
.test { 
	background-color : rgba(grey500, 0.5);
 }

')
]
