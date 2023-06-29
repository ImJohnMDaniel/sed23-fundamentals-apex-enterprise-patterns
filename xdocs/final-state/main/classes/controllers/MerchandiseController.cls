public with sharing class MerchandiseController 
{
    // method used to provide a list of products for selection
    @AuraEnabled(cacheable=true)
    public static List<Product2> productsToDisplay()
    {
        try 
        {
            // *** SELECTOR-02
            // return [SELECT CreatedById, CreatedDate, Description, DisplayUrl, ExternalDataSourceId
            //              , ExternalId, Family, Id, IsActive, IsArchived, IsDeleted, LastModifiedById
            //              , LastModifiedDate, LastReferencedDate, LastViewedDate
            //              , Name, ProductCode, QuantityUnitOfMeasure, StockKeepingUnit, SystemModstamp
            //           FROM Product2 
            //          WHERE IsActive = true
            //          ORDER BY Family, Name];
            return ProductsSelector.newInstance().selectActive();
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Id createNewOrder(Id accountId)
    {
        /* SERVICE-01
        try {
            // *** SELECTOR-01
            // Account customerAccount = [SELECT Id, Name
            //                                 , BillingStreet
            //                                 , BillingCity, BillingState, BillingPostalCode, BillingCountry
            //                              FROM Account 
            //                             WHERE Id = :accountId];
            list<Account> customerAccounts = AccountsSelector.newInstance().selectById( new Set<Id>{ accountId } );

            Account customerAccount = customerAccounts[0];

            // create the new order record
            // *** DOMAINS-02
            // Order newOrder = new Order();
            Order newOrder = Orders.newOrderForAccount(customerAccount);

            // setup order defaults
            // *** DOMAIN-01
            // newOrder.ActivatedById = UserInfo.getUserId();

            // default info from customer account
            // *** DOMAIN-02
            // newOrder.AccountId = accountId;
        
            // *** DOMAINS-02
            // default the billing address to be the billing address from associated account
            // newOrder.BillingStreet = customerAccount.BillingStreet;
            // newOrder.BillingCity = customerAccount.BillingCity;
            // newOrder.BillingState = customerAccount.BillingState;
            // newOrder.BillingPostalCode = customerAccount.BillingPostalCode;
            // newOrder.BillingCountry = customerAccount.BillingCountry;

            // Save the Order 
            insert newOrder;

            // return the order Id
            return newOrder.Id;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        */

        // SERVICE-01
        try 
        {
            return OrdersService.createNewOrder(accountId);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }

    @AuraEnabled
    public static void addToOrder(Id orderId, String productName, Integer requestedQuantity)
    {
        
        try 
        {
            /*
            // get the order record
            // *** SELECTOR-01
            // Order currentOrder = [SELECT Id, OrderNumber FROM Order WHERE Id = :orderId];
            List<Order> orders = OrdersSelector.newInstance().selectById(new Set<Id>{ orderId });
            Order currentOrder = orders[0];
            
            // find the product
            Product2 productRequested = null;
            // *** SELECTOR-02
            // try 
            // {
            //     List<Product2> products = [SELECT CreatedById, CreatedDate, Description, DisplayUrl, ExternalDataSourceId
            //                                    , ExternalId, Family, Id, IsActive, IsArchived, IsDeleted, LastModifiedById
            //                                    , LastModifiedDate, LastReferencedDate, LastViewedDate
            //                                    , Name, ProductCode, QuantityUnitOfMeasure, StockKeepingUnit, SystemModstamp
            //                                 FROM Product2
            //                                WHERE Name = :productName
            //                                LIMIT 1];
            //     productRequested = products[0];
            // }
            // catch (System.QueryException qe)
            // {
            //     // this exception occurs if the product cannot be found 
            // }
            // catch (Exception e)
            // {
            //
            // }
            List<Product2> products = ProductsSelector.newInstance().selectByName( new Set<String>{ productName });
            productRequested = products[0];

            // add the product to the order -- OrderItem
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.OrderId = currentOrder.Id;
            newOrderItem.Quantity = requestedQuantity;
            newOrderItem.Product2Id = productRequested.Id;
            
            // save the order and update the warehouse quantity
            insert newOrderItem;
            */
            // SERVICE-01B
            OrdersService.addToOrder(orderId, productName, requestedQuantity);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
