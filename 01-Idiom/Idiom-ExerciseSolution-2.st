!classDefinition: #NotFound category: #'Idiom-ExerciseSolution-2'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-ExerciseSolution-2'!


!classDefinition: #IdiomTest category: #'Idiom-ExerciseSolution-2'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-ExerciseSolution-2'!

!IdiomTest methodsFor: 'testing' stamp: 'HAW 4/14/2017 17:36:17'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self 
		should: [ customerBook addCustomerNamed: 'John Lennon' ]
		notTakeMoreThanMilliseconds: 50
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'HAW 4/14/2017 17:40:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self 
		should: [ customerBook removeCustomerNamed: paulMcCartney ]
		notTakeMoreThanMilliseconds: 100
! !

!IdiomTest methodsFor: 'testing' stamp: 'HAW 4/14/2017 17:41:00'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self 
		should: [ customerBook addCustomerNamed: '' ]
		raise: Error
		asserting: [ :anError |  
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'HAW 4/14/2017 17:43:02'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		should: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		raise: NotFound 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!IdiomTest methodsFor: 'assertions' stamp: 'HAW 4/14/2017 17:47:37'!
should: aBlock notTakeMoreThanMilliseconds: aLimit

	| elapsedTime |
	
	elapsedTime _ Time millisecondsToRun: aBlock value.
	
	self assert: elapsedTime < aLimit 
! !

!IdiomTest methodsFor: 'assertions' stamp: 'HAW 4/14/2017 17:42:18'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock 
	! !


!classDefinition: #CustomerBook category: #'Idiom-ExerciseSolution-2'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-ExerciseSolution-2'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-ExerciseSolution-2'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
