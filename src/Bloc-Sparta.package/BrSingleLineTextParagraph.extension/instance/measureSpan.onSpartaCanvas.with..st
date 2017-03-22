*Bloc-Sparta
measureSpan: aSpan onSpartaCanvas: aSpartaCanvas with: aContext
	| aTextPainter aMetricsProvider aTextRun aTextRunIterator aMetrics anEndOffset |

	self
		assert: [ aSpan isNotEmpty ]
		description: [ 'Span must be non-empty!' ].
	
	aContext span: aSpan.

	
	aTextPainter := self createSpartaTextPainter: aSpan on: aSpartaCanvas.
	aContext maxWidth isInfinite
		ifTrue: [ aTextPainter breakNone ]
		ifFalse: [ aTextPainter breakWordWrap ].
	aMetrics := aTextPainter metrics.
	aMetricsProvider := aTextPainter metricsProvider.
	aTextRun := aTextPainter textRun.
	self wantsAutoRelease
		ifTrue: [ aTextRun autoRelease ].
	self
		assert: [ aTextRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].
	aTextRun metricsProvider: aMetricsProvider.

	aContext start: 1.
	aContext length: aTextRun size.

	anEndOffset := 0.
	aTextRunIterator := aTextRun iterator.

	[ aContext wantsMore ] whileTrue: [
		| span anEnd aFromOffset  |

			aMetrics width: aContext transformedAvailableWidth.
			aMetrics start: aContext start.


			aMetricsProvider measure: aTextRun in: aMetrics.
			"wrapped end is index of last visible glyph, not character"
			anEnd := aMetrics wrappedEnd.

			aFromOffset := aTextRunIterator position - 1.
			aTextRunIterator skipUnits: anEnd - aContext start + 1.
			anEndOffset := aTextRunIterator position - 2.

			span := aContext hasTransformation
				ifFalse: [ SpTextSpan
						rope: text
						segment: aSpan
						start: aContext start "should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"	
						end: anEnd "should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"
						from: aContext position + aFromOffset
						to: aContext position + anEndOffset
						metrics: aMetrics
						textRun: aTextRun
						attributes: aContext span attributes ]
				ifTrue: [ SpTextSpan
						rope: text
						segment: aSpan
						start: aContext start "should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"	
						end: anEnd "should be in string buffer coordinates (respecting 1 vs 2 vs 4 bits per character)"	
						from: aContext position + aFromOffset
						to: aContext position + anEndOffset
						metrics: aMetrics
						transform: aContext transformation
						transformInverted: aContext inverseTransformation
						textRun: aTextRun
						attributes: aContext span attributes ].

			aContext pushSpan: span.
			aContext start: anEnd + 1 ].
	aContext pushPosition: anEndOffset