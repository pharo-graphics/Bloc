initialize-release
initializeSpan: aSpan on: aCanvas with: aContext
	| attributes aTextPainter aLength aStart transform transformInverted aMetricsProvider aTextRun aMetrics |
	self
		assert: [ aSpan isNotEmpty ]
		description: [ 'Span must be non-empty!' ].
	attributes := aSpan attributes.
	transform := SpartaMatrix new.
	attributes
		do: [ :attribute | attribute applyOnSpartaMatrix: transform with: aSpan ].
	aTextPainter := self createPainter: aSpan on: aCanvas.
	aStart := 1.
	transformInverted := transform inverted.
	aMetrics := aTextPainter metrics.
	aMetricsProvider := aTextPainter metricsProvider.
	aTextRun := aTextPainter textRun.
	self wantsAutoRelease
		ifTrue: [ aTextRun autoRelease ].

	"Length is amount of glyphs, not characters!"
	aLength := aTextRun length.
	self
		assert: [ aTextRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].
	aTextRun metricsProvider: aMetricsProvider.
	[ aStart <= aLength and: [ aContext availableHeight > 0 ] ]
		whileTrue: [ | span anEnd |
			"here we skip all left whitespace after break"
			aContext isSplitted
				ifTrue:
					[ "white space" aStart := self skipWhitespaceIn: aTextPainter string after: aStart ].
			aMetrics
				width:
					(transformInverted transformX: aContext availableWidth)
						- transform translation x.
			aMetrics start: aStart.
			aMetricsProvider measure: aTextRun in: aMetrics.
			anEnd := aMetrics wrappedEnd.
			"to can be less than from, meaning that there are no fully visible characters that fit in available width"
			anEnd < aStart
				ifTrue: [ aMetrics width: Float infinity.
					aMetrics length: aStart - aMetrics start + 1.
					aMetricsProvider measure: aTextRun in: aMetrics.
					anEnd := aMetrics wrappedEnd ].
			span := SpTextSpan
				rope: rope
				segment: aSpan
				start: aStart
				end: anEnd
				from: aContext position
				to: aContext position + (anEnd - aStart)
				metrics: aMetrics
				transform: transform
				transformInverted: transformInverted
				textRun: aTextRun
				attributes: attributes.	"should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"	"should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"
			aContext pushSpan: span.
			aContext isSplitted
				ifTrue: [ aContext pushLine ].
			aStart := anEnd + 1 ].
	aContext pushPosition: aStart - 1 - aLength