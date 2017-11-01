examples
parallelLoop
	"<script: 'self parallelLoop'> "
	| sp el cAnim |
	sp := BlSpace new.
	el := BlElement new
		background: (BlBackground paint: Color blue);
		extent: 100 @ 100;
		position: 100 @ 100.
	cAnim := BlParallelAnimation new
		target: el;
		loop:4;
		scale:[:s| s scaleTo: 1@2; duration: 500];
		rotate:[:r| r angle: 90; duration: 500].
		
		
	sp root addChild: el.
	sp show.
	cAnim start