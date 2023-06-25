// *** SELECTOR-01
public interface IAccountsSelector extends fflib_ISObjectSelector 
{
	List<Account> selectById(Set<Id> idSet);
	// List<Account> selectByOpportunity(List<Opportunity> opportunities);
}