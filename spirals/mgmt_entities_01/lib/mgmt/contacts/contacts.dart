part of mgmt_contacts; 
 
// lib/mgmt/contacts/contacts.dart 
 
class Contact extends ContactGen { 
 
  Contact(Concept concept) : super(concept); 
 
  Contact.withId(Concept concept, String email) : 
    super.withId(concept, email); 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
class Contacts extends ContactsGen { 
 
  Contacts(Concept concept) : super(concept); 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
