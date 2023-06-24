public with sharing class MerchandiseController 
{
    // method used to provide a list of products for selection
    @AuraEnabled(cacheable=true)
    public static List<Product2> productsToDisplay()
    {
        try 
        {
            return [SELECT CreatedById, CreatedDate, Description, DisplayUrl, ExternalDataSourceId
                         , ExternalId, Family, Id, IsActive, IsArchived, IsDeleted, LastModifiedById
                         , LastModifiedDate, LastReferencedDate, LastViewedDate
                         , Name, ProductCode, QuantityUnitOfMeasure, StockKeepingUnit, SystemModstamp
                      FROM Product2 
                     WHERE IsActive = true
                     ORDER BY Family, Name];
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    // - createNewOrder
    //     - query Account
    //     - defaulting a order 
    //         - customer discount?
    //             - query Account
    public static Id createNewOrder(Id accountId)
    {
        try {
            Account customerAccount = [SELECT Id, Name
                                            , BillingStreet
                                            , BillingCity, BillingState, BillingPostalCode, BillingCountry
                                         FROM Account 
                                        WHERE Id = :accountId];

            // create the new order record
            Order newOrder = new Order();

            // setup order defaults
            newOrder.AccountId = accountId;
            newOrder.ActivatedById = UserInfo.getUserId();

            // default the billing address to be the billing address from associated account
            newOrder.BillingStreet = customerAccount.BillingStreet;
            newOrder.BillingCity = customerAccount.BillingCity;
            newOrder.BillingState = customerAccount.BillingState;
            newOrder.BillingPostalCode = customerAccount.BillingPostalCode;
            newOrder.BillingCountry = customerAccount.BillingCountry;

            // Save the Order 
            insert newOrder;

            // return the order Id
            return newOrder.Id;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void addToOrder(Id orderId, String productName, Integer requestedQuantity)
    {
        try 
        {
            // get the order record
            Order currentOrder = [SELECT Id, OrderNumber FROM Order WHERE Id = :orderId];
            
            // find the product
            Product2 productRequested = null;
            try 
            {
                List<Product2> product = [SELECT CreatedById, CreatedDate, Description, DisplayUrl, ExternalDataSourceId
                                               , ExternalId, Family, Id, IsActive, IsArchived, IsDeleted, LastModifiedById
                                               , LastModifiedDate, LastReferencedDate, LastViewedDate
                                               , Name, ProductCode, QuantityUnitOfMeasure, StockKeepingUnit, SystemModstamp
                                            FROM Product2
                                           WHERE Name = :productName
                                           LIMIT 1];
            }
            catch (System.QueryException qe)
            {
                // this exception occurs if the product cannot be found 
            }
            catch (Exception e)
            {

            }

            // add the product to the order -- OrderItem
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.OrderId = currentOrder.Id;
            newOrderItem.Quantity = requestedQuantity;


            // save the order and update the qarehouse quantity
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
