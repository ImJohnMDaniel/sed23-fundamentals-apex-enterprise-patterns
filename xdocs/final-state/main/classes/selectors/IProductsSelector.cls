// *** SELECTOR-02
public interface IProductsSelector extends fflib_ISObjectSelector 
{
    List<Product2> selectById(Set<Id> idSet);
	List<Product2> selectActive();
    List<Product2> selectByName(Set<String> nameSet);
}