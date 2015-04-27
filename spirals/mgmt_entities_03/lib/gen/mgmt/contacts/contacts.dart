part of mgmt_contacts; 
 
// lib/gen/mgmt/contacts/contacts.dart 
 
abstract class ContactGen extends ConceptEntity<Contact> { 
 
  ContactGen(Concept concept) {
    this.concept = concept;
  }
 
  ContactGen.withId(Concept concept, String email) { 
    this.concept = concept;
    setAttribute("email", email); 
  } 
 
  String get email => getAttribute("email"); 
  set email(String a) => setAttribute("email", a); 
  
  String get firstName => getAttribute("firstName"); 
  set firstName(String a) => setAttribute("firstName", a); 
  
  String get lastName => getAttribute("lastName"); 
  set lastName(String a) => setAttribute("lastName", a); 
  
  String get telephone => getAttribute("telephone"); 
  set telephone(String a) => setAttribute("telephone", a); 
  
  String get description => getAttribute("description"); 
  set description(String a) => setAttribute("description", a); 
  
  Contact newEntity() => new Contact(concept); 
  Contacts newEntities() => new Contacts(concept); 
  
  int emailCompareTo(Contact other) { 
    return email.compareTo(other.email); 
  } 
 
} 
 
abstract class ContactsGen extends Entities<Contact> { 
 
  ContactsGen(Concept concept) {
    this.concept = concept;
  }
 
  Contacts newEntities() => new Contacts(concept); 
  Contact newEntity() => new Contact(concept); 
  
} 
 
