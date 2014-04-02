 
part of mgmt_contacts; 
 
// lib/mgmt/contacts/model.dart 
 
class ContactsModel extends ContactsEntries { 
 
  ContactsModel(Model model) : super(model); 
 
  fromJsonToContactEntry() { 
    fromJsonToEntry(mgmtContactsContactEntry); 
  } 
 
  fromJsonToModel() { 
    fromJson(mgmtContactsModel); 
  } 
 
  init() { 
    initContacts(); 
  } 
 
  initContacts() { 
    var contact1 = new Contact(contacts.concept); 
      contact1.email = 'carol@reyes.com'; 
      contact1.firstName = 'baby'; 
      contact1.lastName = 'word'; 
      contact1.telephone = 'algorithm'; 
      contact1.description = 'test'; 
      contacts.add(contact1); 
 
    var contact2 = new Contact(contacts.concept); 
      contact2.email = 'john@brown.com'; 
      contact2.firstName = 'accident'; 
      contact2.lastName = 'college'; 
      contact2.telephone = 'tag'; 
      contact2.description = 'smog'; 
      contacts.add(contact2); 
 
    var contact3 = new Contact(contacts.concept); 
      contact3.email = 'barbara@carter.com'; 
      contact3.firstName = 'country'; 
      contact3.lastName = 'effort'; 
      contact3.telephone = 'message'; 
      contact3.description = 'sun'; 
      contacts.add(contact3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
