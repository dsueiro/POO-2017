!classDefinition: #DistanceTest category: #'Distance-Exercise'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro dosMetros cienCentimetros milMilimetros unMedioMetro diezKilometros tresMetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Exercise'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:13:46'!
setUp
	unMetro := Distance newWith: 1 in: 'm'.
	dosMetros := Distance newWith: 2 in: 'm'.
	cienCentimetros := Distance newWith: 100 in: 'cm'.
	milMilimetros := Distance newWith: 1000 in: 'mm'.
	unMedioMetro := Distance newWith: 0.5 in: 'm'.
	diezKilometros := Distance newWith: 10 in: 'km'.
	tresMetros := Distance newWith: 3 in: 'm'! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:34:52'!
test01UnMetroIgualUnMetro
	self assert: unMetro = unMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:34:57'!
test02UnMetroMasUnMetroEsDosMetros
	self assert: (unMetro + unMetro) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:37:34'!
test03UnMetroEsIgualACienCentimetros
	self assert: unMetro = cienCentimetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:59:55'!
test04DosMetrosMenosCienCentimetrosEsIgualAMilMilimetros
	self assert: (dosMetros - cienCentimetros) = milMilimetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:44:30'!
test05UnMetroEstrellaDosEsIgualADosMetros
	self assert: (unMetro * 2) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:46:52'!
test06DosEstrellaUnMetroEsIgualADosMetros
	self assert: (2 * unMetro) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:59:55'!
test07UnMetroBarraDosEsIgualAUnMedioMetro
	self assert: (unMetro / 2) = unMedioMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:05:36'!
test08DiezKilometrosAnguloIzquierdoUnMetroEsVerdadero
	self assert: diezKilometros > unMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:14:44'!
test09UnMetroAnguloDerechoTresMetrosEsVerdadero
	self assert: unMetro < tresMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:18:18'!
test10DiezKilometrosAnguloIzquierdoIgualUnMetroEsVerdadero
	self assert: diezKilometros >= unMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:20:26'!
test11UnMetroAnguloDerechoIgualTresMetrosEsVerdadero
	self assert: unMetro <= tresMetros! !


!classDefinition: #Distance category: #'Distance-Exercise'!
Object subclass: #Distance
	instanceVariableNames: 'magnitude unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Exercise'!

!Distance methodsFor: 'accessing' stamp: 'PEP 5/21/2017 22:18:03'!
magnitude: aMagnitude 
	magnitude := aMagnitude! !

!Distance methodsFor: 'accessing' stamp: 'PEP 5/22/2017 00:11:42'!
magnitudeInMeters
	^unit = 'm' ifTrue: [magnitude] ifFalse:
		[unit = 'cm' ifTrue:
			[magnitude / 100] ifFalse: [
				unit = 'mm' ifTrue: [magnitude / 1000] ifFalse: [
					unit = 'km' ifTrue: [magnitude * 1000]]]]! !

!Distance methodsFor: 'accessing' stamp: 'PEP 5/21/2017 22:55:53'!
magnitudeInMetersEquals: aMagnitudeInMeters 
	^self magnitudeInMeters = aMagnitudeInMeters! !

!Distance methodsFor: 'accessing' stamp: 'PEP 5/21/2017 22:18:33'!
unit: aUnit 
	unit := aUnit! !


!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:46:09'!
* aNumber 
	^Distance newWith: (self magnitudeInMeters * 2) in: 'm'! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:23:06'!
+ aDistance 
	^Distance newWith: (magnitude + aDistance magnitude) in: 'm'! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:16:13'!
- aDistance 
	^Distance newWith: (aDistance substractMagnitudeInMeters: self magnitudeInMeters) in: 'm'! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:59:17'!
/ aNumber 
	^Distance newWith: (self magnitudeInMeters / 2) in: 'm'! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:15:32'!
< aDistance 
	^aDistance magnitudeInMetersIsGreaterThan: self magnitudeInMeters ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:21:04'!
<= aDistance 
	^aDistance magnitudeInMetersIsGreaterOrEqualThan: self magnitudeInMeters ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:50:49'!
= aDistance 
	^ aDistance magnitudeInMetersEquals: self magnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:07:01'!
> aDistance 
	^aDistance magnitudeInMetersIsSmallerThan: self magnitudeInMeters ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:18:58'!
>= aDistance 
	^aDistance magnitudeInMetersIsSmallerOrEqualThan: self magnitudeInMeters ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:55:18'!
adaptToInteger: aNumber andSend: aSelector
	^ self perform: aSelector with: aNumber! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:24:06'!
magnitude
	^magnitude! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:22:01'!
magnitudeInMetersIsGreaterOrEqualThan: aMagnitudeInMeters
	^self magnitudeInMeters >= aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:16:17'!
magnitudeInMetersIsGreaterThan: aMagnitudeInMeters 
	^self magnitudeInMeters > aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:19:49'!
magnitudeInMetersIsSmallerOrEqualThan: aMagnitudeInMeters 
	^self magnitudeInMeters <= aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:09:44'!
magnitudeInMetersIsSmallerThan: aMagnitudeInMeters
	^self magnitudeInMeters < aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:18:31'!
substractMagnitudeInMeters: aMagnitudeInMeters
	^aMagnitudeInMeters - self magnitudeInMeters ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Exercise'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'initialization' stamp: 'PEP 5/21/2017 22:17:23'!
newWith: aMagnitude in: aUnit 
	^self new magnitude: aMagnitude; unit: aUnit; yourself! !
