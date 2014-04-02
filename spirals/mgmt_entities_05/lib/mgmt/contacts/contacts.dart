part of mgmt_contacts; 
 
// lib/mgmt/contacts/contacts.dart 
 
class Contact extends ContactGen { 
 
  Contact(Concept concept) : super(concept); 
 
  Contact.withId(Concept concept, String email) : 
    super.withId(concept, email); 
 
  // added after code gen - begin 
 
  /**
   * Compares two contacts based on the last and first names.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact other) {
    var c = lastName.compareTo(other.lastName);
    if (c == 0) {
      return firstName.compareTo(other.firstName);
    }
    return c;
  }
  
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
 
