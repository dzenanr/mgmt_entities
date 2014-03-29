part of mgmt_contacts; 
 
// lib/gen/mgmt/models.dart 
 
class MgmtModels extends DomainModels { 
 
  MgmtModels(Domain domain) : super(domain) { 
    // fromJsonToModel function from dartling/lib/domain/model/transfer.json.dart 
 
    Model model = fromJsonToModel(mgmtContactsModelJson, domain, "Contacts"); 
    ContactsModel contactsModel = new ContactsModel(model); 
    add(contactsModel); 
 
  } 
 
} 
 
