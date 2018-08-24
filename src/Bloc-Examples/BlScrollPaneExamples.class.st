Class {
	#name : #BlScrollPaneExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Scrolling'
}

{ #category : #'examples - fling down' }
BlScrollPaneExamples >> _1_flingDownWithOvershoot500_first205ms [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 205 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: { 0. 2. 5. 7. 10. 12. 14. 16. 18. 20. 22. 24. 26. 27. 29. 30. 32. 33. 35. 36. 38. 39. 40. 41. 42. 43. 44. 45. 45. 46. 47. 47. 48. 48. 49. 49. 50. 50. 50. 50. 50 }.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: 0).
	self assert: aScrollerY currentPosition equals: 50.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: aScrollerY deceleration equals: -2500.
	self assert: aScrollerY duration equals: 200 milliSeconds.
	self assert: aScrollerY finalPosition equals: 50.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: 84.
	self assert: aScrollerY splineDuration equals: 485 milliSeconds.
	self assert: aScrollerY startPosition equals: 0.
	self assert: aScrollerY startTime equals: self simulatedDate.
	self assert: aScrollerY startVelocity equals: 500.

	^ aScrollPane
]

{ #category : #'examples - fling down' }
BlScrollPaneExamples >> _1_flingDownWithOvershoot500_first305ms [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 300 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. 2. 5. 7. 10. 12. 14. 16. 18. 20. 22. 24. 26. 27. 29. 30. 32. 33. 35. 36. 38. 39. 40. 41. 42. 43. 44. 45. 45. 46. 47. 47. 48. 48. 49. 49. 50. 50. 50. 50. 50. 50. 50. 49. 49. 48. 48. 47. 46. 45. 44. 42. 41. 40. 38. 37. 35. 34. 32. 31}.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: 73.3576).
	self assert: aScrollerY currentPosition equals: 31.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: aScrollerY deceleration equals: -2000.
	self assert: aScrollerY duration equals: 223 milliSeconds.
	self assert: aScrollerY finalPosition equals: 0.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: 84.
	self assert: aScrollerY splineDuration equals: 485 milliSeconds.
	self assert: aScrollerY startPosition equals: 50.
	self assert: aScrollerY startTime equals: self simulatedDate + 200 milliSeconds.
	self assert: aScrollerY startVelocity equals: -50.

	^ aScrollPane
]

{ #category : #'examples - fling up' }
BlScrollPaneExamples >> _1_flingUp500_first205ms [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |

	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500) negated.
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) negated asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 200 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. -2. -5. -7. -10. -12. -15. -17. -19. -21. -24. -26. -28. -30. -32. -34. -36. -38. -39. -41. -43. -44. -46. -47. -49. -50. -51. -53. -54. -55. -56. -58. -59. -60. -61. -62. -63. -64. -64. -65}.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: -167.16293).
	self assert: aScrollerY currentPosition equals: -65.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aScrollerY deceleration equals: 0.
	self assert: aScrollerY duration equals: 485 milliSeconds.
	self assert: aScrollerY finalPosition equals: -84.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: -84.
	self assert: aScrollerY splineDuration equals: 485 milliSeconds.
	self assert: aScrollerY startPosition equals: 0.
	self assert: aScrollerY startTime equals: self simulatedDate.
	self assert: aScrollerY startVelocity equals: -500.

	^ aScrollPane
]

{ #category : #'examples - fling down' }
BlScrollPaneExamples >> _2_flingDownWithOvershoot500_first205ms_flingDown500 [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self _1_flingDownWithOvershoot500_first205ms.
	aScrollPane flingBy: (0@500).
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: 500).
	self assert: aScrollerY currentPosition equals: 0.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: aScrollerY deceleration equals: -4489.
	self assert: aScrollerY duration equals: 149 milliSeconds.
	self assert: aScrollerY finalPosition equals: 50.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: 84.
	self assert: aScrollerY splineDuration equals: 0 milliSeconds.
	self assert: aScrollerY startPosition equals: 0.
	self assert: aScrollerY startTime equals: self simulatedDate + 115 milliSeconds.
	self assert: aScrollerY startVelocity equals: 670.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@50.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 290 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: { 42. 43. 45. 46. 47. 47. 48. 49. 49. 50. 50. 50. 50. 50. 50. 49. 49. 48. 47. 47. 46. 44. 43. 42. 41. 39. 38. 37. 35. 33. 32. 30. 29. 27. 25. 23. 22. 20. 19. 17. 15. 14. 12. 11. 9. 8. 7. 6. 5. 4. 3. 2. 1. 1. 0. 0. 0. 0}.

	^ aScrollPane
]

{ #category : #'examples - fling up' }
BlScrollPaneExamples >> _2_flingUp500_flingUp500 [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self _1_flingUp500_first205ms.
	
	aScrollPane flingBy: (0@500) negated.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: -667).
	self assert: aScrollerY currentPosition equals: -65.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aScrollerY deceleration equals: 0.
	self assert: aScrollerY duration equals: 600 milliSeconds.
	self assert: aScrollerY finalPosition equals: -205.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: -140.
	self assert: aScrollerY splineDuration equals: 600 milliSeconds.
	self assert: aScrollerY startPosition equals: -65.
	self assert: aScrollerY startTime equals: self simulatedDate + 195 milliSeconds.
	self assert: aScrollerY startVelocity equals: -667.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@65 negated.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 605 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {-68. -72. -75. -78. -82. -85. -88. -91. -94. -97. -100. -103. -106. -109. -112. -115. -117. -120. -123. -125. -127. -130. -132. -134. -137. -139. -141. -143. -145. -147. -149. -150. -152. -154. -156. -157. -159. -160. -162. -163. -165. -166. -167. -169. -170. -171. -172. -174. -175. -176. -177. -178. -179. -180. -181. -182. -183. -183. -184. -185. -186. -187. -188. -188. -189. -190. -190. -191. -192. -192. -193. -193. -194. -194. -195. -195. -196. -196. -197. -197. -198. -198. -199. -199. -199. -200. -200. -200. -201. -201. -201. -202. -202. -202. -202. -202. -203. -203. -203. -203. -203. -204. -204. -204. -204. -204. -204. -204. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205}.

	^ aScrollPane
]

{ #category : #'examples - fling up' }
BlScrollPaneExamples >> _2_flingUp500_flingUp500Twice [
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self _1_flingUp500_first205ms.
	
	aScrollPane flingBy: (0@500) negated.
	aScrollPane flingBy: (0@500) negated.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: -1167).
	self assert: aScrollerY currentPosition equals: -65.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aScrollerY deceleration equals: 0.
	self assert: aScrollerY duration equals: 906 milliSeconds.
	self assert: aScrollerY finalPosition equals: -435.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: -370.
	self assert: aScrollerY splineDuration equals: 906 milliSeconds.
	self assert: aScrollerY startPosition equals: -65.
	self assert: aScrollerY startTime equals: self simulatedDate + 195 milliSeconds.
	self assert: aScrollerY startVelocity equals: -1167.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@65 negated.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 910 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: { -71. -77. -82. -88. -94. -100. -106. -111. -117. -123. -128. -134. -139. -145. -150. -155. -161. -166. -171. -176. -181. -186. -191. -196. -200. -205. -209. -214. -218. -223. -227. -231. -235. -240. -244. -247. -251. -255. -259. -263. -266. -270. -273. -277. -280. -283. -287. -290. -293. -296. -299. -302. -305. -308. -310. -313. -316. -319. -321. -324. -326. -329. -331. -333. -336. -338. -340. -342. -345. -347. -349. -351. -353. -355. -357. -359. -361. -362. -364. -366. -368. -369. -371. -373. -374. -376. -377. -379. -380. -382. -383. -385. -386. -387. -389. -390. -391. -392. -394. -395. -396. -397. -398. -399. -400. -401. -403. -404. -405. -406. -406. -407. -408. -409. -410. -411. -412. -413. -413. -414. -415. -416. -416. -417. -418. -418. -419. -420. -420. -421. -422. -422. -423. -423. -424. -424. -425. -425. -426. -426. -427. -427. -428. -428. -428. -429. -429. -430. -430. -430. -431. -431. -431. -431. -432. -432. -432. -432. -433. -433. -433. -433. -433. -434. -434. -434. -434. -434. -434. -434. -435. -435. -435. -435. -435. -435. -435. -435. -435. -435. -435. -435}.

	^ aScrollPane
]

{ #category : #'examples - instance creation' }
BlScrollPaneExamples >> contentElement [
	<gtExample>
	
	^ BlElement new
		size: self contentExtent;
		background: (Color gray)
]

{ #category : #accessing }
BlScrollPaneExamples >> contentExtent [
	
	^ 800@600
]

{ #category : #'examples - fling down' }
BlScrollPaneExamples >> flingDownWithOvershoot500Complete [
	<gtExample>
	| aScrollPane theScrollPositions |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 430 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: { 0. 2. 5. 7. 10. 12. 14. 16. 18. 20. 22. 24. 26. 27. 29. 30. 32. 33. 35. 36. 38. 39. 40. 41. 42. 43. 44. 45. 45. 46. 47. 47. 48. 48. 49. 49. 50. 50. 50. 50. 50. 50. 50. 49. 49. 48. 48. 47. 46. 45. 44. 42. 41. 40. 38. 37. 35. 34. 32. 31. 29. 27. 26. 24. 22. 20. 19. 17. 16. 14. 13. 11. 10. 8. 7. 6. 5. 4. 3. 2. 1. 1. 0. 0. 0. 0 }.

	^ aScrollPane
]

{ #category : #'examples - fling up' }
BlScrollPaneExamples >> flingUp500Complete [
	<gtExample>
	| aScrollPane theScrollPositions |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500 negated).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	
	"make sure we are in sync with the space time"
	self
		assert: aScrollPane scrollFlinger scroller time
		equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500 negated) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 495 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. -2. -5. -7. -10. -12. -15. -17. -19. -21. -24. -26. -28. -30. -32. -34. -36. -38. -39. -41. -43. -44. -46. -47. -49. -50. -51. -53. -54. -55. -56. -58. -59. -60. -61. -62. -63. -64. -64. -65. -66. -67. -68. -68. -69. -70. -71. -71. -72. -72. -73. -74. -74. -75. -75. -76. -76. -77. -77. -77. -78. -78. -78. -79. -79. -80. -80. -80. -80. -81. -81. -81. -81. -82. -82. -82. -82. -82. -83. -83. -83. -83. -83. -83. -83. -83. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84}.

	^ aScrollPane
]

{ #category : #'examples - fling consecutive' }
BlScrollPaneExamples >> flingUpDownConsecutive [
	<gtExample>
	| aScrollPane theScrollPositions theVelocities |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane size: self largeScrollPaneExtent.
	aScrollPane scrolledElement size: self largeContentExtent.
	
	theScrollPositions := OrderedCollection new.
	theVelocities := OrderedCollection new.
	
	aScrollPane flingBy: (0@500).
	aScrollPane space time
		every: 1 milliSeconds
		during: 24 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
	
	aScrollPane flingBy: (0@500).
	aScrollPane space time
		every: 1 milliSeconds
		during: 131 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
		
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.
		
	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.
		
	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.

	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time
		every: 1 milliSeconds
		during: 131 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
	
	^ aScrollPane
]

{ #category : #'examples - grid' }
BlScrollPaneExamples >> gridInScrollPane [
	<gtExample>
	| aGridElement aScrollPane |
	
	aGridElement := BlElement new.
	aGridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	aGridElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	aGridElement addChildren: (50 timesCollect: [ :anIndex |
		BlTextElement new
			text: (anIndex asString asRopedText foreground: Color gray);
			size: 120@120;
			background: (Color gray alpha: (20 to: 50) atRandom / 100.0)]).

	aScrollPane := BlScrollableElement new.
	aScrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aScrollPane addChild: aGridElement.

	^ aScrollPane.
]

{ #category : #accessing }
BlScrollPaneExamples >> largeContentExtent [
	
	^ 1600@1200
]

{ #category : #accessing }
BlScrollPaneExamples >> largeScrollPaneExtent [
	
	^ 800@600
]

{ #category : #'examples - instance creation' }
BlScrollPaneExamples >> scrollPaneElement [
	<gtExample>
	
	^ BlScrollableElement new
		size: self scrollPaneExtent;
		background: (Color white);
		border: (BlBorder paint: Color darkGray width: 2)
]

{ #category : #accessing }
BlScrollPaneExamples >> scrollPaneExtent [
	
	^ 200@100
]

{ #category : #'examples - instance creation' }
BlScrollPaneExamples >> scrollPaneWithContent [
	<gtExample>
	
	^ self scrollPaneElement addChild: self contentElement
]

{ #category : #'examples - instance creation' }
BlScrollPaneExamples >> scrollPaneWithContentInSpace [
	<gtExample>
	| aSpace aScrollPane |
	
	aScrollPane := self scrollPaneWithContent.
	
	aSpace := self spaceWithSumulatedTime.
	aSpace root addChild: aScrollPane.
	
	aSpace pulse.
	
	self assert: aScrollPane extent equals: self scrollPaneExtent.
	self assert: aScrollPane position equals: 0@0.
	
	self assert: aScrollPane scrolledElement extent equals: self contentExtent.
	self assert: aScrollPane scrolledElement position equals: 0@0.
	
	self assert: aScrollPane scrollPosition equals: 0@0.
	self assert: aScrollPane scrollOvershot equals: (self scrollPaneExtent / 2.0).
	self assert: aScrollPane scrollMinimum equals: (self scrollPaneExtent - self contentExtent).
	self assert: aScrollPane scrollMaximum equals: (0@0).
	
	self assert: aScrollPane canScrollHorizontally.
	self assert: aScrollPane canScrollVertically.

	^ aScrollPane
]

{ #category : #accessing }
BlScrollPaneExamples >> simulatedDate [
	^ DateAndTime year: 2018 month: 5 day: 2
]

{ #category : #'examples - instance creation' }
BlScrollPaneExamples >> spaceWithSumulatedTime [
	<gtExample>

	^ BlSpace new time: (BlTime simulated date: self simulatedDate)
]
