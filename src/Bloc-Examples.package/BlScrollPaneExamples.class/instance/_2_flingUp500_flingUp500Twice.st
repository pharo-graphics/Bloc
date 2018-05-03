examples - fling up
_2_flingUp500_flingUp500Twice
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