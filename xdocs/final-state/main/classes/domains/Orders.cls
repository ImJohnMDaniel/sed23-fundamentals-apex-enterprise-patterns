// *** DOMAINS-01
public with sharing class Orders extends fflib_SObjectDomain
	implements IOrders
{
	public static final String OPPORTUNITY_RAISED_DESCRIPTION = 'Last Opportunity Raised';

	public static IOrders newInstance(List<Order> recordList)
	{
		// return (IOrders) Application.Domain.newInstance(recordList);
        return new Orders(recordList);
	}
	
	// public static IOrders newInstance(Set<Id> recordIdSet)
	// {
	// 	return (IOrders) Application.Domain.newInstance(recordIdSet);
	// }
	
	public Orders(List<Order> sObjectList)
	{
		super(sObjectList, Schema.Order.SObjectType);
	}

    public override void onApplyDefaults()
    {
        for (SObject record : this.records)
        {
            ((Order)record).ActivatedById = UserInfo.getUserId();
        }
    }

	// *** DOMAINS-02
	public static Order newOrderForAccount(Account customerAccount)
	{
		Order newOrder = new Order();
		newOrder.AccountId = customerAccount.Id;
		// default the billing address to be the billing address from associated account
		newOrder.BillingStreet = customerAccount.BillingStreet;
		newOrder.BillingCity = customerAccount.BillingCity;
		newOrder.BillingState = customerAccount.BillingState;
		newOrder.BillingPostalCode = customerAccount.BillingPostalCode;
		newOrder.BillingCountry = customerAccount.BillingCountry;

		return newOrder;
	}

	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_SObjects construct(List<Object> objectList)
		{
			return new Orders((List<SObject>) objectList);
		}
	}
}