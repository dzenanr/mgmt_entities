 
// test/mgmt/contacts/mgmt_contacts_gen.dart 
 
import "package:mgmt_contacts/mgmt_contacts.dart"; 
 
genCode(Repository repository) { 
  repository.gen("mgmt_contacts"); 
} 
 
initData(Repository repository) { 
   var mgmtDomain = repository.getDomainModels("Mgmt"); 
   var contactsModel = mgmtDomain.getModelEntries("Contacts"); 
   contactsModel.init(); 
   //contactsModel.display(); 
} 
 
void main() { 
  var repository = new Repository(); 
  genCode(repository); 
  //initData(repository); 
} 
 
