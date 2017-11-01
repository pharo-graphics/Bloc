examples
sequentialLoop
	"<script: 'self sequentialLoop'> "
	| sp el cAnim |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground paint: Color blue);
		extent: 100 @ 100;
		position: 100 @ 100.
	cAnim := BlSequentialAnimation new
		target: el;
		loop:2;
		translate:[:t| t to: 300@0; duration: 500];
		translate:[:t| t to: 300@300; duration: 500];
		translate:[:t| t to: 0@300; duration: 500];
		translate:[:t| t to: 0@0; duration: 500].
		
		
	sp root addChild: el.
	sp show.
	cAnim start