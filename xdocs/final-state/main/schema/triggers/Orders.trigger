// *** DOMAINS-01
trigger Orders on Order 
    (after delete, after insert, after update, before delete, before insert, before update) 
{
    fflib_SObjectDomain.triggerHandler(Orders.class);
}