// *** SELECTOR-01
public class OrdersSelector extends fflib_SObjectSelector
	implements IOrdersSelector
{
	public static IOrdersSelector newInstance()
	{
		// return (IOrdersSelector) Application.Selector.newInstance(Order.SObjectType);
        return new OrdersSelector();
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			Order.Id,
			Order.Name,
            Order.OrderNumber,
			Order.Description
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Order.SObjectType;
	}

	public List<Order> selectById(Set<Id> idSet)
	{
		return (List<Order>) selectSObjectsById(idSet);
	}
}