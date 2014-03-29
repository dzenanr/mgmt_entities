 
// test/mgmt/contacts/mgmt_contacts_contact_test.dart 
 
import "package:unittest/unittest.dart"; 
import "package:dartling/dartling.dart"; 
import "package:mgmt_contacts/mgmt_contacts.dart"; 
 
testMgmtContactsContacts( 
    MgmtDomain mgmtDomain, ContactsModel contactsModel, Contacts contacts) { 
  DomainSession session; 
  group("Testing Mgmt.Contacts.Contact", () { 
    session = mgmtDomain.newSession();  
    expect(contactsModel.isEmpty, isTrue); 
    setUp(() { 
      contactsModel.init(); 
    }); 
    tearDown(() { 
      contactsModel.clear(); 
    }); 
 
    test("Not empty model", () { 
      expect(contactsModel.isEmpty, isFalse); 
      expect(contacts.isEmpty, isFalse); 
    }); 
 
    test("Empty model", () { 
      contactsModel.clear(); 
      expect(contactsModel.isEmpty, isTrue); 
      expect(contacts.isEmpty, isTrue); 
      expect(contacts.errors.isEmpty, isTrue); 
    }); 
 
    test("From model to JSON", () { 
      var json = contactsModel.toJson(); 
      expect(json, isNotNull); 
 
      print(json); 
      //contactsModel.displayJson(); 
      //contactsModel.display(); 
    }); 
 
    test("From JSON to model", () { 
      var json = contactsModel.toJson(); 
      contactsModel.clear(); 
      expect(contactsModel.isEmpty, isTrue); 
      contactsModel.fromJson(json); 
      expect(contactsModel.isEmpty, isFalse); 
 
      contactsModel.display(); 
    }); 
 
    test("From model entry to JSON", () { 
      var json = contactsModel.fromEntryToJson("Contact"); 
      expect(json, isNotNull); 
 
      print(json); 
      //contactsModel.displayEntryJson("Contact"); 
      //contactsModel.displayJson(); 
      //contactsModel.display(); 
    }); 
 
    test("From JSON to model entry", () { 
      var json = contactsModel.fromEntryToJson("Contact"); 
      contacts.clear(); 
      expect(contacts.isEmpty, isTrue); 
      contactsModel.fromJsonToEntry(json); 
      expect(contacts.isEmpty, isFalse); 
 
      contacts.display(title: "From JSON to model entry"); 
    }); 
 
    test("Add contact required error", () { 
      var contactConcept = contacts.concept; 
      var contactCount = contacts.length; 
      var contact = new Contact(contactConcept); 
      var added = contacts.add(contact); 
      expect(added, isFalse); 
      expect(contacts.length, equals(contactCount)); 
      expect(contacts.errors.length, greaterThan(0)); 
      expect(contacts.errors.toList()[0].category, equals("required")); 
 
      contacts.errors.display(title: "Add contact required error"); 
    }); 
 
    test("Add contact unique error", () { 
      var contactConcept = contacts.concept; 
      var contactCount = contacts.length; 
      var contact = new Contact(contactConcept); 
      var randomContact = contacts.random(); 
      contact.email = randomContact.email; 
      var added = contacts.add(contact); 
      expect(added, isFalse); 
      expect(contacts.length, equals(contactCount)); 
      expect(contacts.errors.length, greaterThan(0)); 
 
      contacts.errors.display(title: "Add contact unique error"); 
    }); 
 
    test("Not found contact by new oid", () { 
      var dartlingOid = new Oid.ts(1345648254063); 
      var contact = contacts.singleWhereOid(dartlingOid); 
      expect(contact, isNull); 
    }); 
 
    test("Find contact by oid", () { 
      var randomContact = contacts.random(); 
      var contact = contacts.singleWhereOid(randomContact.oid); 
      expect(contact, isNotNull); 
      expect(contact, equals(randomContact)); 
    }); 
 
    test("Find contact by attribute id", () { 
      var randomContact = contacts.random(); 
      var contact = 
          contacts.singleWhereAttributeId("email", randomContact.email); 
      expect(contact, isNotNull); 
      expect(contact.email, equals(randomContact.email)); 
    }); 
 
    test("Find contact by required attribute", () { 
      var randomContact = contacts.random(); 
      var contact = 
          contacts.firstWhereAttribute("firstName", randomContact.firstName); 
      expect(contact, isNotNull); 
      expect(contact.firstName, equals(randomContact.firstName)); 
    }); 
 
    test("Find contact by attribute", () { 
      var randomContact = contacts.random(); 
      var contact = 
          contacts.firstWhereAttribute("telephone", randomContact.telephone); 
      expect(contact, isNotNull); 
      expect(contact.telephone, equals(randomContact.telephone)); 
    }); 
 
    test("Select contacts by attribute", () { 
      var randomContact = contacts.random(); 
      var selectedContacts = 
          contacts.selectWhereAttribute("telephone", randomContact.telephone); 
      expect(selectedContacts.isEmpty, isFalse); 
      selectedContacts.forEach((se) => 
          expect(se.telephone, equals(randomContact.telephone))); 
 
      //selectedContacts.display(title: "Select contacts by telephone"); 
    }); 
 
    test("Select contacts by required attribute", () { 
      var randomContact = contacts.random(); 
      var selectedContacts = 
          contacts.selectWhereAttribute("firstName", randomContact.firstName); 
      expect(selectedContacts.isEmpty, isFalse); 
      selectedContacts.forEach((se) => 
          expect(se.firstName, equals(randomContact.firstName))); 
 
      //selectedContacts.display(title: "Select contacts by firstName"); 
    }); 
 
    test("Select contacts by attribute, then add", () { 
      var randomContact = contacts.random(); 
      var selectedContacts = 
          contacts.selectWhereAttribute("firstName", randomContact.firstName); 
      expect(selectedContacts.isEmpty, isFalse); 
      expect(selectedContacts.source.isEmpty, isFalse); 
      var contactsCount = contacts.length; 
 
      var contact = new Contact(contacts.concept); 
      contact.email = 'dave@flores.com'; 
      contact.firstName = 'authority'; 
      contact.lastName = 'train'; 
      contact.telephone = 'oil'; 
      contact.description = 'milk'; 
      var added = selectedContacts.add(contact); 
      expect(added, isTrue); 
      expect(contacts.length, equals(++contactsCount)); 
 
      //selectedContacts.display(title: 
      //  "Select contacts by attribute, then add"); 
      //contacts.display(title: "All contacts"); 
    }); 
 
    test("Select contacts by attribute, then remove", () { 
      var randomContact = contacts.random(); 
      var selectedContacts = 
          contacts.selectWhereAttribute("firstName", randomContact.firstName); 
      expect(selectedContacts.isEmpty, isFalse); 
      expect(selectedContacts.source.isEmpty, isFalse); 
      var contactsCount = contacts.length; 
 
      var removed = selectedContacts.remove(randomContact); 
      expect(removed, isTrue); 
      expect(contacts.length, equals(--contactsCount)); 
 
      randomContact.display(prefix: "removed"); 
      //selectedContacts.display(title: 
      //  "Select contacts by attribute, then remove"); 
      //contacts.display(title: "All contacts"); 
    }); 
 
    test("Sort contacts", () { 
      contacts.sort(); 
 
      //contacts.display(title: "Sort contacts"); 
    }); 
 
    test("Order contacts", () { 
      var orderedContacts = contacts.order(); 
      expect(orderedContacts.isEmpty, isFalse); 
      expect(orderedContacts.length, equals(contacts.length)); 
      expect(orderedContacts.source.isEmpty, isFalse); 
      expect(orderedContacts.source.length, equals(contacts.length)); 
      expect(orderedContacts, isNot(same(contacts))); 
 
      //orderedContacts.display(title: "Order contacts"); 
    }); 
 
    test("Copy contacts", () { 
      var copiedContacts = contacts.copy(); 
      expect(copiedContacts.isEmpty, isFalse); 
      expect(copiedContacts.length, equals(contacts.length)); 
      expect(copiedContacts, isNot(same(contacts))); 
      copiedContacts.forEach((e) => 
        expect(e, equals(contacts.singleWhereOid(e.oid)))); 
      copiedContacts.forEach((e) => 
        expect(e, isNot(same(contacts.singleWhereId(e.id))))); 
 
      //copiedContacts.display(title: "Copy contacts"); 
    }); 
 
    test("True for every contact", () { 
      expect(contacts.every((e) => e.firstName != null), isTrue); 
    }); 
 
    test("Random contact", () { 
      var contact1 = contacts.random(); 
      expect(contact1, isNotNull); 
      var contact2 = contacts.random(); 
      expect(contact2, isNotNull); 
 
      //contact1.display(prefix: "random1"); 
      //contact2.display(prefix: "random2"); 
    }); 
 
    test("Update contact id with try", () { 
      var randomContact = contacts.random(); 
      var beforeUpdate = randomContact.email; 
      try { 
        randomContact.email = 'ryan@collins.com'; 
      } on UpdateError catch (e) { 
        expect(randomContact.email, equals(beforeUpdate)); 
      } 
    }); 
 
    test("Update contact id without try", () { 
      var randomContact = contacts.random(); 
      var beforeUpdateValue = randomContact.email; 
      expect(() => randomContact.email = 'dan@clark.com', throws); 
      expect(randomContact.email, equals(beforeUpdateValue)); 
    }); 
 
    test("Update contact id with success", () { 
      var randomContact = contacts.random(); 
      var afterUpdateEntity = randomContact.copy(); 
      var attribute = randomContact.concept.attributes.singleWhereCode("email"); 
      expect(attribute.update, isFalse); 
      attribute.update = true; 
      afterUpdateEntity.email = 'gary@young.com'; 
      expect(afterUpdateEntity.email, equals('gary@young.com')); 
      attribute.update = false; 
      var updated = contacts.update(randomContact, afterUpdateEntity); 
      expect(updated, isTrue); 
 
      var entity = contacts.singleWhereAttributeId("email", 'gary@young.com'); 
      expect(entity, isNotNull); 
      expect(entity.email, equals('gary@young.com')); 
 
      //contacts.display("After update contact id"); 
    }); 
 
    test("Update contact non id attribute with failure", () { 
      var randomContact = contacts.random(); 
      var beforeUpdateValue = randomContact.firstName; 
      var afterUpdateEntity = randomContact.copy(); 
      afterUpdateEntity.firstName = 'time'; 
      expect(afterUpdateEntity.firstName, equals('time')); 
      // contacts.update can only be used if oid, code or id is set. 
      expect(() => contacts.update(randomContact, afterUpdateEntity), throws); 
    }); 
 
    test("Copy Equality", () { 
      var randomContact = contacts.random(); 
      randomContact.display(prefix:"before copy: "); 
      var randomContactCopy = randomContact.copy(); 
      randomContactCopy.display(prefix:"after copy: "); 
      expect(randomContact, equals(randomContactCopy)); 
      expect(randomContact.oid, equals(randomContactCopy.oid)); 
      expect(randomContact.code, equals(randomContactCopy.code)); 
      expect(randomContact.email, equals(randomContactCopy.email)); 
      expect(randomContact.firstName, equals(randomContactCopy.firstName)); 
      expect(randomContact.lastName, equals(randomContactCopy.lastName)); 
      expect(randomContact.telephone, equals(randomContactCopy.telephone)); 
      expect(randomContact.description, equals(randomContactCopy.description)); 
 
      expect(randomContact.id, isNotNull); 
      expect(randomContactCopy.id, isNotNull); 
      expect(randomContact.id, equals(randomContactCopy.id)); 
 
      var idsEqual = false; 
      if (randomContact.id == randomContactCopy.id) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
 
      idsEqual = false; 
      if (randomContact.id.equals(randomContactCopy.id)) { 
        idsEqual = true; 
      } 
      expect(idsEqual, isTrue); 
    }); 
 
    test("New contact action undo and redo", () { 
      var contactConcept = contacts.concept; 
      var contactCount = contacts.length; 
          var contact = new Contact(contacts.concept); 
      contact.email = 'maria@morgan.com'; 
      contact.firstName = 'selfie'; 
      contact.lastName = 'ball'; 
      contact.telephone = 'car'; 
      contact.description = 'cabinet'; 
      contacts.add(contact); 
      expect(contacts.length, equals(++contactCount)); 
      contacts.remove(contact); 
      expect(contacts.length, equals(--contactCount)); 
 
      var action = new AddAction(session, contacts, contact); 
      action.doit(); 
      expect(contacts.length, equals(++contactCount)); 
 
      action.undo(); 
      expect(contacts.length, equals(--contactCount)); 
 
      action.redo(); 
      expect(contacts.length, equals(++contactCount)); 
    }); 
 
    test("New contact session undo and redo", () { 
      var contactConcept = contacts.concept; 
      var contactCount = contacts.length; 
          var contact = new Contact(contacts.concept); 
      contact.email = 'jose@brown.com'; 
      contact.firstName = 'call'; 
      contact.lastName = 'kids'; 
      contact.telephone = 'salad'; 
      contact.description = 'objective'; 
      contacts.add(contact); 
      expect(contacts.length, equals(++contactCount)); 
      contacts.remove(contact); 
      expect(contacts.length, equals(--contactCount)); 
 
      var action = new AddAction(session, contacts, contact); 
      action.doit(); 
      expect(contacts.length, equals(++contactCount)); 
 
      session.past.undo(); 
      expect(contacts.length, equals(--contactCount)); 
 
      session.past.redo(); 
      expect(contacts.length, equals(++contactCount)); 
    }); 
 
    test("Contact update undo and redo", () { 
      var contact = contacts.random(); 
      var action = new SetAttributeAction(session, contact, "firstName", 'beginning'); 
      action.doit(); 
 
      session.past.undo(); 
      expect(contact.firstName, equals(action.before)); 
 
      session.past.redo(); 
      expect(contact.firstName, equals(action.after)); 
    }); 
 
    test("Contact action with multiple undos and redos", () { 
      var contactCount = contacts.length; 
      var contact1 = contacts.random(); 
 
      var action1 = new RemoveAction(session, contacts, contact1); 
      action1.doit(); 
      expect(contacts.length, equals(--contactCount)); 
 
      var contact2 = contacts.random(); 
 
      var action2 = new RemoveAction(session, contacts, contact2); 
      action2.doit(); 
      expect(contacts.length, equals(--contactCount)); 
 
      //session.past.display(); 
 
      session.past.undo(); 
      expect(contacts.length, equals(++contactCount)); 
 
      session.past.undo(); 
      expect(contacts.length, equals(++contactCount)); 
 
      //session.past.display(); 
 
      session.past.redo(); 
      expect(contacts.length, equals(--contactCount)); 
 
      session.past.redo(); 
      expect(contacts.length, equals(--contactCount)); 
 
      //session.past.display(); 
    }); 
 
    test("Transaction undo and redo", () { 
      var contactCount = contacts.length; 
      var contact1 = contacts.random(); 
      var contact2 = contacts.random(); 
      while (contact1 == contact2) { 
        contact2 = contacts.random();  
      } 
      var action1 = new RemoveAction(session, contacts, contact1); 
      var action2 = new RemoveAction(session, contacts, contact2); 
 
      var transaction = new Transaction("two removes on contacts", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      transaction.doit(); 
      contactCount = contactCount - 2; 
      expect(contacts.length, equals(contactCount)); 
 
      contacts.display(title:"Transaction Done"); 
 
      session.past.undo(); 
      contactCount = contactCount + 2; 
      expect(contacts.length, equals(contactCount)); 
 
      contacts.display(title:"Transaction Undone"); 
 
      session.past.redo(); 
      contactCount = contactCount - 2; 
      expect(contacts.length, equals(contactCount)); 
 
      contacts.display(title:"Transaction Redone"); 
    }); 
 
    test("Transaction with one action error", () { 
      var contactCount = contacts.length; 
      var contact1 = contacts.random(); 
      var contact2 = contact1; 
      var action1 = new RemoveAction(session, contacts, contact1); 
      var action2 = new RemoveAction(session, contacts, contact2); 
 
      var transaction = new Transaction( 
        "two removes on contacts, with an error on the second", session); 
      transaction.add(action1); 
      transaction.add(action2); 
      var done = transaction.doit(); 
      expect(done, isFalse); 
      expect(contacts.length, equals(contactCount)); 
 
      //contacts.display(title:"Transaction with an error"); 
    }); 
 
    test("Reactions to contact actions", () { 
      var contactConcept = contacts.concept; 
      var contactCount = contacts.length; 
 
      var reaction = new ContactReaction(); 
      expect(reaction, isNotNull); 
 
      mgmtDomain.startActionReaction(reaction); 
          var contact = new Contact(contacts.concept); 
      contact.email = 'ali@king.com'; 
      contact.firstName = 'unit'; 
      contact.lastName = 'girl'; 
      contact.telephone = 'big'; 
      contact.description = 'plate'; 
      contacts.add(contact); 
      expect(contacts.length, equals(++contactCount)); 
      contacts.remove(contact); 
      expect(contacts.length, equals(--contactCount)); 
 
      var session = mgmtDomain.newSession(); 
      var addAction = new AddAction(session, contacts, contact); 
      addAction.doit(); 
      expect(contacts.length, equals(++contactCount)); 
      expect(reaction.reactedOnAdd, isTrue); 
 
      var setAttributeAction = new SetAttributeAction( 
        session, contact, "firstName", 'selfdo'); 
      setAttributeAction.doit(); 
      expect(reaction.reactedOnUpdate, isTrue); 
      mgmtDomain.cancelActionReaction(reaction); 
    }); 
 
  }); 
} 
 
class ContactReaction implements ActionReactionApi { 
  bool reactedOnAdd    = false; 
  bool reactedOnUpdate = false; 
 
  react(BasicAction action) { 
    if (action is EntitiesAction) { 
      reactedOnAdd = true; 
    } else if (action is EntityAction) { 
      reactedOnUpdate = true; 
    } 
  } 
} 
 
void main() { 
  var repository = new Repository(); 
  var mgmtDomain = repository.getDomainModels("Mgmt");   
  assert(mgmtDomain != null); 
  var contactsModel = mgmtDomain.getModelEntries("Contacts");  
  assert(contactsModel != null); 
  var contacts = contactsModel.contacts; 
  testMgmtContactsContacts(mgmtDomain, contactsModel, contacts); 
} 
 
