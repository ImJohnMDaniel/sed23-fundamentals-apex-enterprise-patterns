// *** SELECTOR-01
public interface IOrdersSelector extends fflib_ISObjectSelector 
{
    List<Order> selectById(Set<Id> idSet);
}