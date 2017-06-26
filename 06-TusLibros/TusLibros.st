!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'book1 cartWithOneBook1 emptyCatalog catalogWithOneBook emptyCartWithCatalogWithOneBook emptyCartWithEmptyCatalog priceListWithThreeItems cartWithFiveOneBooks book2 catalogWithMultipleBooks cartWithMultipleBooks salesBook merchantProcessor storeTestFactory merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator expiredCard validCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:20:01'!
setUp
	storeTestFactory _ StoreTestFactory new.
	
	salesBook _ storeTestFactory createSalesBook.
	
	emptyCatalog := Set new.
	emptyCartWithEmptyCatalog := Cart with: emptyCatalog.
	
	book1 := 'Un libro'.
	book2 := 'Dos libro'.

	catalogWithOneBook := Set new.
	catalogWithOneBook add: book1.

	catalogWithMultipleBooks := Set new.
	catalogWithMultipleBooks add: book1.
	catalogWithMultipleBooks add: book2.

	emptyCartWithCatalogWithOneBook := Cart with: catalogWithOneBook.
	
	cartWithOneBook1 := Cart with: catalogWithOneBook.
	cartWithOneBook1 add: book1.
	
	priceListWithThreeItems := storeTestFactory createPriceListWithThreeItems.
	
	cartWithFiveOneBooks := Cart with: catalogWithOneBook.
	cartWithFiveOneBooks add: book1 withAmount: 5.
	
	cartWithMultipleBooks := Cart with: catalogWithMultipleBooks.
	cartWithMultipleBooks add: book1 withAmount: 3.
	cartWithMultipleBooks add: book2 withAmount: 4.

	validCard := CreditCard withName: 'Juan Perez' withNumber: 1000000000000000 withExpirationDate: Date tomorrow.
	expiredCard := CreditCard withName: 'Juan Perez' withNumber: 1000000000000000 withExpirationDate: Date yesterday.
	
	merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator := storeTestFactory createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:31:34'!
test01ANewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:32:59'!
test02AfterAddingABookACartIsNotEmpty
	emptyCartWithCatalogWithOneBook add: book1.
	self deny: emptyCartWithCatalogWithOneBook isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:33:35'!
test03AfterAddingABookTheCartContainsOneBook1
	self assert: (cartWithOneBook1 includes: book1).
	self assert: (cartWithOneBook1 quantityOf: book1) equals: 1! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:33:57'!
test04BeforeAddingABookTheCartDoesNotContainsIt
	self deny: (emptyCartWithEmptyCatalog includes: book1).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:34:32'!
test05CannotAddABookWithQuantityLessThanOne
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 0]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add quantity less than one'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:34:47'!
test06CannotAddABookWithANonIntegerQuantity
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 1.1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a non integer quantity'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 06:35:16'!
test07CannotAddABookThatIsNotFromTheCatalog
	self should: [emptyCartWithEmptyCatalog add: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog'.
		self assert: emptyCartWithEmptyCatalog isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:15:51'!
test08CannotCreateACashierWithAnEmptyCart	
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: emptyCartWithCatalogWithOneBook 
		                             withCreditCard: creditCardExpiredOn052012 
		                             withPaymentTimestamp: DateAndTime now
		                             withSalesBook: salesBook
		                             withMerchantProcessor: merchantProcessor]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot create a cashier with an empty cart']
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:25:25'!
test09ACashierDoCheckoutWithAnCartWithFiveOneBook
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
		                         withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
						    withMerchantProcessor: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator.
	
	self assert: 5 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.
	self assert: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator merchantProcessorWasCalled.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:25:39'!
test10ACashierDoCheckoutWithACartWithMultipleBooks
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithMultipleBooks 
	                              withCreditCard:  validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator.
	
	self assert: 11 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.
	self assert: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator merchantProcessorWasCalled.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:22'!
test11CannotCreateACreditCardWithAnEmptyName
	self should: [CreditCard withName: '' 
		                                   withNumber: 12345 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Name cannot be empty'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:42'!
test12CannotCreateACreditCardWithAPositiveNumberLessThanSixteenLength
	self should: [CreditCard withName: 'Juan Perez' 
		                                   withNumber: 999999999999999 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Number must have at least 16 numbers'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:14:06'!
test13ACreditCardWithAnExpirationDateLessThanADayIsExpired
	|creditCard|
	
	creditCard := CreditCard withName: 'Juan Perez' 
	                                         withNumber: 1000000000000000 
	                                         withExpirationDate: (Date newDay: 01 month: 05 year: 2012).
	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 5 year: 2012)).	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 8 year: 2012)).
	self assert: (creditCard isExpiredOn: (Date newDay: 1 month: 1 year: 2017)).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:28:13'!
test14CannotCreateACashierWithACreditcardExpired
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: cartWithFiveOneBooks 
		                             withCreditCard: expiredCard 
		                             withPaymentTimestamp: DateAndTime now
		                             withSalesBook: salesBook
		                             withMerchantProcessor: merchantProcessor]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Expired credit card'.]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:26:21'!
test15ACashierCannotDoCheckoutWithAStolenCreditCard
	|cashier merchantProcessor| 
	
	merchantProcessor := MerchantProcessorSimulator withIsStolenCard: true withCreditAmount: 500.
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkout] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'The credit card was stolen'.
		self assert: cashier salesBook isEmpty.
		self deny: merchantProcessor merchantProcessorWasCalled]
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:26:25'!
test16ACashierCannotDoCheckoutWithACreditCardWithoutEnoughCredit
	|cashier merchantProcessor| 
	
	merchantProcessor := MerchantProcessorSimulator withIsStolenCard: false withCreditAmount: 2.
	
	cashier := Cashier withPriceList: priceListWithThreeItems
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkout] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'The credit card does not have enough credit'.
		self assert: cashier salesBook isEmpty.
		self deny: merchantProcessor merchantProcessorWasCalled]
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/25/2017 16:16:08'!
test17CreateACartWithAValidUser
	|store cartId|
	
	store _ storeTestFactory createAStoreWithUsers.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	
	self assert: (store listCartWith: cartId) isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/25/2017 16:15:19'!
test18CreateACartWithAInvalidUserClientId
	|store|
	
	store _ storeTestFactory createAStoreWithUsers.
	
	self should: [store createCartFor: 'clientId' authenticatedWith: 'password']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/25/2017 16:15:08'!
test19CreateACartWithAInvalidUserPassword
	|store|
	
	store _ storeTestFactory createAStoreWithUsers.
	
	self should: [store createCartFor: 'clientId1' authenticatedWith: 'password']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/25/2017 18:14:40'!
test20AddingABookFromTheStoreToCartTheCartShouldIncludeIt
	|store cartId cartOrder |
	
	store _ storeTestFactory createAStoreWithUsers.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 5.

	cartOrder _ (store listCartWith: cartId).
	self deny: cartOrder isEmpty.
	self assert: (cartOrder content includes: 'Un libro').
	self assert: 5 equals: (cartOrder content occurrencesOf: 'Un libro').
	self assert: store salesBook isEmpty! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/25/2017 18:15:01'!
test21AddingANonExtingBookInStoreShouldNotBeAddedToCart
	|store cartId |
	
	store _ storeTestFactory createAStoreWithUsers.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	
	self should: [store addToCartWith: cartId withBookISBN: 'Un libro2' withBookAmount: 1] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog'.
		self assert: (store listCartWith: cartId) isEmpty.
		self assert: store salesBook isEmpty]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:24:45'!
test22CanDoCheckoutWithValidCardAnOneBookAddedToCart
	|store cartId |
	
	store _ storeTestFactory createAStoreWithUsers.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	store checkoutWith: cartId withCreditCard: validCard.
 	self deny: store salesBook isEmpty! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:24:10'!
test23CannotDoCheckoutWithExpiredCard
	|store cartId |
	
	store _ storeTestFactory createAStoreWithUsers.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	self should: [store checkoutWith: cartId withCreditCard: expiredCard.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Expired credit card'.
		self assert: store salesBook isEmpty]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'inspecting' stamp: 'PEP 6/13/2017 00:02:35'!
initialize
	content := Bag new! !

!Cart methodsFor: 'inspecting' stamp: 'PEP 6/12/2017 22:15:34'!
isEmpty
	^content isEmpty! !


!Cart methodsFor: 'adding' stamp: 'DHS 6/13/2017 21:00:47'!
add: aCartItem
	self add: aCartItem withAmount: 1! !

!Cart methodsFor: 'adding' stamp: 'masch 6/14/2017 07:10:45'!
add: aBook withAmount: aQuantity 
	self validateQuantity: aQuantity.
	self validateCatalog: aBook.
	content add: aBook withOccurrences: aQuantity.
	^aBook! !


!Cart methodsFor: 'evaluating' stamp: 'PEP 6/13/2017 00:04:43'!
includes: aBook
	^content includes: aBook! !

!Cart methodsFor: 'evaluating' stamp: 'masch 6/25/2017 17:30:57'!
occurrencesOf: aBookISBN
	^content occurrencesOf: aBookISBN ! !

!Cart methodsFor: 'evaluating' stamp: 'masch 6/14/2017 07:09:56'!
quantityOf: aBook 
	^content occurrencesOf: aBook! !


!Cart methodsFor: 'initializing' stamp: 'masch 6/14/2017 07:02:27'!
catalog: aCatalog
	catalog := aCatalog.! !


!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:11:37'!
validateCatalog: aBook
	(catalog includes: aBook) ifFalse: [self error: 'Cannot add a book outside the catalog'].! !

!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:08:42'!
validateQuantity: aQuantity.
	aQuantity strictlyPositive ifFalse: [self error: 'Cannot add quantity less than one'].
	aQuantity isInteger ifFalse: [self error: 'Cannot add a non integer quantity'].! !


!Cart methodsFor: 'accessing' stamp: 'masch 6/21/2017 07:01:11'!
content
	^content! !

!Cart methodsFor: 'accessing' stamp: 'PEP 6/25/2017 14:35:28'!
totalPrice: aPricesList 
	|totalPrice|
		
	totalPrice := 0.
	content asSet do: [ :contentItem |
		totalPrice := (aPricesList at: contentItem) * (content occurrencesOf: contentItem) + totalPrice].
	
	^totalPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'masch 6/21/2017 06:03:56'!
with: aCatalog
	^self new catalog: aCatalog; yourself ! !


!classDefinition: #CartOrder category: #TusLibros!
Object subclass: #CartOrder
	instanceVariableNames: 'id content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 16:43:18'!
add: anISBN
	content add: anISBN! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:07:58'!
add: anISBN withAmount: anAmount
	content add: anISBN withAmount: anAmount! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:14:50'!
content
	^content ! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:16:37'!
content: aContent 
	content _ aContent! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:13:34'!
id  
	^id! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:12:18'!
id: anId 
	id _ anId! !

!CartOrder methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:15:12'!
isEmpty
	^content isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartOrder class' category: #TusLibros!
CartOrder class
	instanceVariableNames: ''!

!CartOrder class methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:15:59'!
withId: anId 
	^self new id: anId; content: OrderedCollection new; yourself! !

!CartOrder class methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 16:40:26'!
withId: anId withCart: aCart
	^self new id: anId; content: aCart; yourself! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:18:28'!
cart: aCart 
	cart := aCart ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 08:06:53'!
checkout
	|salePrice|
	
	salePrice := cart totalPrice: priceList.
	merchantProcessor debitFrom: cart withAmount: salePrice.
		
	salesBook addSale: salePrice.
	^salePrice
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 07:23:28'!
merchantProcessor: aMerchantProcessor 
	merchantProcessor := aMerchantProcessor ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/21/2017 06:24:57'!
priceList: aPriceList
	priceList := aPriceList ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:08:58'!
salesBook
	^salesBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:05:25'!
salesBook: aSalesBook
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'PEP 6/26/2017 00:14:07'!
withPriceList: aPriceList withCart: aCart withCreditCard: aCreditCard withPaymentTimestamp: aPaymentTimestamp withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	self validateCart: aCart.
	self validateCardOn: aCreditCard withPaymentDay: aPaymentTimestamp date.

	^ self new priceList: aPriceList; cart: aCart; salesBook: aSalesBook; merchantProcessor: aMerchantProcessor; yourself! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'PEP 6/26/2017 00:21:57'!
validateCardOn: aCreditCard withPaymentDay: aPaymentDay 
	(aCreditCard isExpiredOn: aPaymentDay) ifTrue: [self error: 'Expired credit card'].! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:25:48'!
validateCart: aCart 
	(aCart isEmpty) ifTrue: [self error: 'Cannot create a cashier with an empty cart'].! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:36:47'!
expirationDate: anExpirationDate 
	expirationDate := anExpirationDate! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 17:51:27'!
isExpiredOn: aDateFrom 
	^expirationDate < aDateFrom! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:28:40'!
name: aName 
	name := aName ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:32:29'!
number: aNumber 
	number := aNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:20:16'!
validateName: aName
	(aName isEmpty) ifTrue: [ self error: 'Name cannot be empty'].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:29:24'!
validateNumber: aNumber 
	(aNumber < 1000000000000000) ifTrue: [self error: 'Number must have at least 16 numbers'].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:25:13'!
withName: aName withNumber: aNumber withExpirationDate: aExpirationDate
	self validateName: aName.
	self validateNumber: aNumber.
	
	^self new name: aName; number: aNumber; expirationDate: aExpirationDate; yourself! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 08:54:31'!
debitFrom: aCart withAmount: anAmount
	self shouldBeImplemented ! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 09:09:31'!
numberCallsToMerchantProcessor
	self shouldBeImplemented! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'isStolenCard creditAmount numberCallsToMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 08:59:42'!
creditAmount: aCreditAmount 
	creditAmount := aCreditAmount! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 09:18:55'!
debitFrom: aCart withAmount: anAmount
	(isStolenCard) ifTrue: [ self error: 'The credit card was stolen'].
	(creditAmount < anAmount) ifTrue: [self error: 'The credit card does not have enough credit'].
	numberCallsToMerchantProcessor _ numberCallsToMerchantProcessor + 1.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 08:59:33'!
isStoleCard: aIsStolenCard
	isStolenCard := aIsStolenCard! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 09:15:19'!
merchantProcessorWasCalled
	^numberCallsToMerchantProcessor > 0! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 09:14:52'!
numberCallsToMerchantProcessor: aNumberCallsToMerchantProcessor
	numberCallsToMerchantProcessor _ aNumberCallsToMerchantProcessor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 09:12:11'!
withIsStolenCard: aIsStolenCard withCreditAmount: aCreditAmount
	^self new isStoleCard: aIsStolenCard; creditAmount: aCreditAmount; numberCallsToMerchantProcessor: 0; yourself.! !


!classDefinition: #SalesBook category: #TusLibros!
Object subclass: #SalesBook
	instanceVariableNames: 'salesCollectionBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:00:15'!
addSale: aSalePrice
	^salesCollectionBook add: aSalePrice! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:54:16'!
initialize
	salesCollectionBook _ OrderedCollection new.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:51:25'!
isEmpty
	^salesCollectionBook isEmpty.! !


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'cartsOrdersList validsUsers catalog pricesList salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:06:31'!
addToCartWith: aCartId withBookISBN: anISBN withBookAmount: anAmount
	| cartOrder |
	
	cartOrder _ self listCartWith: aCartId.
	cartOrder add: anISBN withAmount: anAmount.! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 16:34:06'!
catalog: aCatalog 
	catalog _ aCatalog! !

!Store methodsFor: 'as yet unclassified' stamp: 'PEP 6/26/2017 00:11:29'!
checkoutWith: aCartOrderId withCreditCard: aCreditCard 
	| cartOrder cashier|

	cartOrder _ cartsOrdersList at: aCartOrderId.

	cashier := Cashier withPriceList: pricesList 
	                              withCart: cartOrder content
	                              withCreditCard: aCreditCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook 
						    withMerchantProcessor: merchantProcessor.
						
	cashier checkout! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 12:19:38'!
createCartFor: aClientId authenticatedWith: aPassword
	| cartOrder |
	
	self validateUserFor: aClientId authenticatedWith: aPassword.
	
	cartOrder _ self createCartOrder.
	self registerCartOrder: cartOrder.
	
	^cartOrder id! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:26:30'!
createCartOrder
	| cartOrderId cart |
	
	cartOrderId _ cartsOrdersList size.
	cart _ Cart with: catalog.
	
	^CartOrder withId: cartOrderId withCart: cart! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:25:38'!
initialize
	cartsOrdersList _ Dictionary new.
	! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:25:22'!
listCartWith: anCartId
	^cartsOrdersList  at: anCartId ifAbsent: [self error: 'Cart id is invalid']! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 18:08:49'!
merchantProcessor: aMerchantProcessor 
	merchantProcessor _ aMerchantProcessor! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:46:11'!
pricesList: aPricesList
	pricesList _ aPricesList! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:25:33'!
registerCartOrder: aCartOrder 
	cartsOrdersList add: (Association key: aCartOrder id value: aCartOrder).
! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 18:13:47'!
salesBook
	^salesBook! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:59:24'!
salesBook: aSalesBook 
	salesBook _ aSalesBook ! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 11:51:08'!
validateUserFor: aClientId authenticatedWith: aPassword
	| user |
	
	user _ validsUsers at: aClientId ifAbsent: [self error: 'Client id is invalid'].
	(user = aPassword) ifFalse: [self error: 'Client id is invalid'].
! !

!Store methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 11:05:36'!
validsUsers: aValidsUsers
	validsUsers _ aValidsUsers! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 18:05:29'!
withValidUsers: aValidsUsers withCatalog: aCatalog withPricesList: aPricesList withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor
	^self new validsUsers: aValidsUsers; catalog: aCatalog; pricesList: aPricesList; salesBook: aSalesBook; merchantProcessor: aMerchantProcessor; yourself! !


!classDefinition: #StoreTestFactory category: #TusLibros!
Object subclass: #StoreTestFactory
	instanceVariableNames: 'validsUsers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestFactory methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 18:11:07'!
createAStoreWithUsers

	| book1 book2 catalogWithMultipleBooks |
	
	book1 := 'Un libro'.
	book2 := 'Dos libro'.

	catalogWithMultipleBooks := Set new.
	catalogWithMultipleBooks add: book1.
	catalogWithMultipleBooks add: book2.

	^Store withValidUsers: validsUsers 
	             withCatalog: catalogWithMultipleBooks 
	             withPricesList: self createPriceListWithThreeItems 
	             withSalesBook: self createSalesBook 
	             withMerchantProcessor: self createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator.! !

!StoreTestFactory methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 18:04:25'!
createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator
	
	^MerchantProcessorSimulator withIsStolenCard: false withCreditAmount: 100.
! !

!StoreTestFactory methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:42:17'!
createPriceListWithThreeItems

	| priceListWithThreeItems |
	
	priceListWithThreeItems := Dictionary new.
	priceListWithThreeItems add: (Association key: 'Un libro' value: 1).
	priceListWithThreeItems add: (Association key: 'Dos libro' value: 2).
	priceListWithThreeItems add: (Association key: 'Tres libro' value: 3).
	
	^priceListWithThreeItems
! !

!StoreTestFactory methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 17:55:16'!
createSalesBook
	^SalesBook new.
! !

!StoreTestFactory methodsFor: 'as yet unclassified' stamp: 'masch 6/25/2017 16:12:39'!
initialize
	validsUsers _ Dictionary new.
	validsUsers add: (Association key: 'clientId1' value: 'password1').! !
