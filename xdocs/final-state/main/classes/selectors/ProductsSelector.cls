// *** SELECTOR-02
public class ProductsSelector extends fflib_SObjectSelector
	implements IProductsSelector
{
	public static IProductsSelector newInstance()
	{
		// return (IProductsSelector) Application.Selector.newInstance(Product2.SObjectType);
        return (IProductsSelector) new ProductsSelector();
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			Product2.Description,
			Product2.Id,
			Product2.IsActive,
			Product2.Name,
			Product2.ProductCode
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Product2.SObjectType;
	}

	public List<Product2> selectById(Set<Id> idSet)
	{
		return (List<Product2>) selectSObjectsById(idSet);
	}

	public List<Product2> selectActive()
    {
        return (List<Product2>) Database.query(newQueryFactory().setCondition(Product2.IsActive + ' = true').toSOQL());
    }

    public List<Product2> selectByName(Set<String> nameSet)
    {
        return (List<Product2>) Database.query(newQueryFactory().setCondition(Product2.Name + ' = :nameSet').toSOQL());
    }
}