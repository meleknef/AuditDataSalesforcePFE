/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-08-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AuditActions {
    //public AuditActions() {} 
//Contact
@AuraEnabled(cacheable=true)
public static Integer getInsertContact() {
    return [
      SELECT COUNT()
      FROM AuditContact__c
      WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Contact')
    ];
  }
  
@AuraEnabled(cacheable=true)
public static Integer getUpdateContact() {
    return [
      SELECT COUNT()
      FROM AuditContact__c
      WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Contact')
    ];
  }
@AuraEnabled(cacheable=true)
public static Integer getDeleteContact() {
    return [
      SELECT COUNT()
      FROM AuditContact__c
      WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Contact')
    ];
  }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getContactActions() {
    Map<String, Integer> m1 = new Map<String, Integer>();
    
    m1.put('Insert', getInsertContact());
    m1.put('Update', getUpdateContact());
    m1.put('Delete', getDeleteContact());
    system.debug(m1);
    
    return m1;
  }
  //Account
@AuraEnabled(cacheable=true)
public static Integer getInsertAccount() {
    return [
      SELECT COUNT()
      FROM AuditAccount__c
      WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Account')
    ];
  }

  /*@AuraEnabled(cacheable=true)
      public static List<AuditAccount__c> getInsertAcct( String searchKey, String sortBy, String sortDirection) {
      
       String query = 'SELECT Name, Action__c, ChangeDate__c FROM AuditAccount__c';
       system.debug('query---'+query);
       if ( searchKey != null && searchKey != '' ) {
           String key = '%' + searchKey + '%';
           query += ' WHERE Name LIKE :key';
       }
       query = query + ' LIMIT 10';
       return Database.query( query );
   }*/

@AuraEnabled(cacheable=true)
public static Integer getUpdateAccount() {
    return [
      SELECT COUNT()
      FROM AuditAccount__c
      WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Account')
    ];
  }
@AuraEnabled(cacheable=true)
public static Integer getDeleteAccount() {
    return [
      SELECT COUNT()
      FROM AuditAccount__c
      WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Account')
    ];
  }

  @AuraEnabled(cacheable=true)
public static Integer getDeletedAccount() {
    return [
      SELECT COUNT()
      FROM AuditAccount__c
      WHERE Action__c IN ('Delete') AND ConcernedObject__c IN ('Account') AND Backup__c = false AND Deleted__c = true
    ];
  }
  @AuraEnabled(cacheable=true)
public static Integer getbackupAccount() {
    return [
      SELECT COUNT()
      FROM AuditAccount__c
      WHERE Action__c IN ('Insert') AND ConcernedObject__c IN ('Account') AND Backup__c = true
    ];
  }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getAccountActions() {
    Map<String, Integer> m1 = new Map<String, Integer>();
    
    m1.put('Insert', getInsertAccount());
    m1.put('Update', getUpdateAccount());
    m1.put('Delete', getDeleteAccount());
    system.debug(m1);
    
    return m1;
  }
  //Lead
@AuraEnabled(cacheable=true)
public static Integer getInsertLead() {
      return [
        SELECT COUNT()
        FROM AuditLead__c
        WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Lead')
      ];
    }
@AuraEnabled(cacheable=true)
public static Integer getUpdateLead() {
      return [
        SELECT COUNT()
        FROM AuditLead__c
        WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Lead')
      ];
    }
@AuraEnabled(cacheable=true)
public static Integer getDeleteLead() {
      return [
        SELECT COUNT()
        FROM AuditLead__c
        WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Lead')
      ];
    }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getLeadActions() {
      Map<String, Integer> m1 = new Map<String, Integer>();
      
      m1.put('Insert', getInsertLead());
      m1.put('Update', getUpdateLead());
      m1.put('Delete', getDeleteLead());
      system.debug(m1);
      
      return m1;
    }
    //Product
@AuraEnabled(cacheable=true)
public static Integer getInsertProduct() {
        return [
          SELECT COUNT()
          FROM AuditProduct__c
          WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Product2')
        ];
      }
@AuraEnabled(cacheable=true)
    public static Integer getUpdateProduct() {
        return [
          SELECT COUNT()
          FROM AuditProduct__c
          WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Product2')
        ];
      }
@AuraEnabled(cacheable=true)
public static Integer getDeleteProduct() {
        return [
          SELECT COUNT()
          FROM AuditProduct__c
          WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Product2')
        ];
      }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getProductActions() {
        Map<String, Integer> m1 = new Map<String, Integer>();
        
        m1.put('Insert', getInsertProduct());
        m1.put('Update', getUpdateProduct());
        m1.put('Delete', getDeleteProduct());
        system.debug(m1);
        
        return m1;
      }
      //Contract
@AuraEnabled(cacheable=true)
public static Integer getInsertContract() {
          return [
            SELECT COUNT()
            FROM AuditContract__c
            WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Contract')
          ];
        }
@AuraEnabled(cacheable=true)
public static Integer getUpdateContract() {
          return [
            SELECT COUNT()
            FROM AuditContract__c
            WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Contract')
          ];
        }
@AuraEnabled(cacheable=true)
public static Integer getDeleteContract() {
          return [
            SELECT COUNT()
            FROM AuditContract__c
            WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Contract')
          ];
        }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getContractActions() {
          Map<String, Integer> m1 = new Map<String, Integer>();
          
          m1.put('Insert', getInsertContract());
          m1.put('Update', getUpdateContract());
          m1.put('Delete', getDeleteContract());
          system.debug(m1);
          
          return m1;
        }

      //opportunity
@AuraEnabled(cacheable=true)
public static Integer getInsertOpportunity() {
            return [
              SELECT COUNT()
              FROM AuditOpportunity__c
              WHERE Action__c IN ('insert') AND ConcernedObject__c IN ('Opportunity')
            ];
          }
@AuraEnabled(cacheable=true)
public static Integer getUpdateOpportunity() {
            return [
              SELECT COUNT()
              FROM AuditOpportunity__c
              WHERE Action__c IN ('update') AND ConcernedObject__c IN ('Opportunity')
            ];
          }
@AuraEnabled(cacheable=true)
public static Integer getDeleteOpportunity() {
            return [
              SELECT COUNT()
              FROM AuditOpportunity__c
              WHERE Action__c IN ('delete') AND ConcernedObject__c IN ('Opportunity')
            ];
          }
@AuraEnabled(cacheable=true)
public static Map<String, Integer> getOpportunityActions() {
           Map<String, Integer> m1 = new Map<String, Integer>();
            
            m1.put('Insert', getInsertOpportunity());
            m1.put('Update', getUpdateOpportunity());
            m1.put('Delete', getDeleteOpportunity());
            system.debug(m1);
            
            return m1;
          }

@AuraEnabled(cacheable=true)
public static Integer countOpportunityactions() {
  return ( getDeleteOpportunity() + getInsertOpportunity() + getUpdateOpportunity());
                    }

@AuraEnabled(cacheable=true)
public static Integer countLeadactions() {
  return ( getDeleteLead() + getInsertLead() + getUpdateLead());
                    }

@AuraEnabled(cacheable=true)
public static Integer countContactactions() {
  return ( getDeleteContact() + getInsertContact() + getUpdateContact());
}

@AuraEnabled(cacheable=true)
public static Integer countContractactions() {
  return ( getDeleteContract() + getInsertContract() + getUpdateContract());
}

@AuraEnabled(cacheable=true)
public static Integer countProductactions() {
  return ( getDeleteProduct() + getInsertProduct() + getUpdateProduct());
}

@AuraEnabled(cacheable=true)
public static Integer countAccountactions() {
            return ( getDeleteAccount() + getInsertAccount() + getUpdateAccount());
}

@AuraEnabled(cacheable=true)
public static Integer counttotalactions() {
        Integer total =countAccountactions() + countProductactions() + countContractactions() + countContactactions() + countLeadactions() + countOpportunityactions();
        System.debug('total : '+ total);
        return (total);
}

@AuraEnabled(cacheable=true)
public static Map<String, Integer> getActions() {
  Map<String,Integer> m2 = new Map<String, Integer>();
    m2.put('Account', countAccountactions());
    m2.put('Contact', countContactActions());
    m2.put('Contract', countContractActions());
    m2.put('Lead', countLeadActions());
    m2.put('Opportunity', countOpportunityActions());
    m2.put('Product', countProductActions());
    System.debug('matrice: ' + m2);
    Integer aa = counttotalactions();
    System.debug('matrice count: ' + aa);
    return m2;
}

@AuraEnabled(cacheable=true)
public static Map<String, Integer> Accountbacks() {
  Map<String,Integer> mA = new Map<String, Integer>();
    mA.put('Deleted', getDeletedAccount());
    mA.put('Backup', getbackupAccount());
    System.debug('matrice backs: '+ mA);
    return mA;
}
}