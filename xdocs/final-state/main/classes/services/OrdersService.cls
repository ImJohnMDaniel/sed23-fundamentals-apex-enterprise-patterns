// SERVICE-01
public with sharing class OrdersService 
{
    // APPFACTORY-01
    // private static IOrdersService service()
	// {
    //     return (IOrdersService) Application.Service.newInstance(IOrdersService.class);
	// }

    // SERVICE-01
    public static Id createNewOrder(Id accountId) 
    {
        list<Account> customerAccounts = AccountsSelector.newInstance().selectById( new Set<Id>{ accountId } );

        Account customerAccount = customerAccounts[0];

        Order newOrder = Orders.newOrderForAccount(customerAccount);

        // Save the Order 
        insert newOrder;

        return newOrder.Id;
    }

    // SERVICE-01B
    // public static void addToOrder(Id orderId, String productName, Integer requestedQuantity)
    public static void addToOrder(Id orderId, map<String, Integer> productCountsRequestedByProductNameMap)
    {
        List<Order> orders = OrdersSelector.newInstance().selectById(new Set<Id>{ orderId });
        Order currentOrder = orders[0];

        // find the product
        Product2 productRequested = null;
        Map<String, Product2> productsByNameMap = new Map<String, Product2>();

        List<Product2> products = ProductsSelector.newInstance().selectByName( productCountsRequestedByProductNameMap.keySet() );
        for (Product2 p : products)
        {
            productsByNameMap.put( p.Name, p );
        }

        List<OrderItem> newOrderItems = new List<OrderItem>();

        // add each product to the order -- OrderItem
        for (String productName : productCountsRequestedByProductNameMap.keySet())
        {
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.OrderId = currentOrder.Id;
            newOrderItem.Quantity = productCountsRequestedByProductNameMap.get(productName);
            newOrderItem.Product2Id = productsByNameMap.get(productName).Id;

            newOrderItems.add(newOrderItem);
        }
        
        // save the order and update the warehouse quantity
        try 
        {
            insert newOrderItems;
        }
        catch (Exception e)
        {
            throw new OrdersServiceException(e);
        }
        

    }
}