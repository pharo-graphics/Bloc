rendering
renderSpan: aSpan with: aTextPainter at: aBaseline
	| aBaselineX aBaselineY |
	
	"we must move baseline by 0.5 pixel to get the best quality"
	aBaselineX := aBaseline x integerPart + 0.5.
	aBaselineY := aBaseline y integerPart + 0.5.
		
	aTextPainter
		text: aSpan textRun;
		start: aSpan textRunStart;
		end: aSpan textRunEnd;
		baseline: aBaselineX @ aBaselineY;
		draw