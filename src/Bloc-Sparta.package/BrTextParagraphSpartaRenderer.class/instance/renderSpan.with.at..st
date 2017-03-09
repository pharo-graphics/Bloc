rendering
renderSpan: aSpan with: aTextPainter at: aBaseline

	aTextPainter
		text: aSpan textRun;
		start: aSpan start;
		end: aSpan end;
		baseline: aBaseline;
		draw