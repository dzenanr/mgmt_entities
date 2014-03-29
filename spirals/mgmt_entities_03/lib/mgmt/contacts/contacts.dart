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
 
  bool preAdd(Contact contact) {
    bool validation = super.preAdd(contact);
    if (validation) {
      validation = contact.email.trim() != '' && 
                   contact.firstName.trim() != '' &&
                   contact.lastName.trim() != '';
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
          '${concept.codePlural}.preAdd: a required attribute cannot be empty.';
        errors.add(error);
      }
    }
    return validation;
  }
  
  // added after code gen - end 
 
} 
 
