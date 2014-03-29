 
// web/mgmt/contacts/mgmt_contacts_web.dart 
 
import "dart:html"; 
 
import "package:dartling_default_app/dartling_default_app.dart"; 
import "package:mgmt_contacts/mgmt_contacts.dart"; 
 
initData(Repository repository) { 
   var mgmtDomain = repository.getDomainModels("Mgmt"); 
   var contactsModel = mgmtDomain.getModelEntries("Contacts"); 
   contactsModel.init(); 
   //contactsModel.display(); 
} 
 
showData(Repository repository) { 
   var mainView = new View(document, "main"); 
   mainView.repo = repository; 
   new RepoMainSection(mainView); 
} 
 
void main() { 
  var repository = new Repository(); 
  initData(repository); 
  showData(repository); 
} 
 
