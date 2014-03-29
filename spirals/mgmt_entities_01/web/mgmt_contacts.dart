import 'package:mgmt_contacts/mgmt_contacts.dart';
import 'package:mgmt_contacts/mgmt_contacts_app.dart';

main() {
  var repository = new Repository(); 
  MgmtModels domain = repository.getDomainModels('Mgmt');
  new ContactsApp(domain);
}